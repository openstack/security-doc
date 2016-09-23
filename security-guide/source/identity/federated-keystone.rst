==================
Federated keystone
==================

:term:`Federated Identity<federated identity>` is a mechanism to
establish trusts between Identity Providers and Service Providers (SP),
in this case, between Identity Providers and the services provided by an
OpenStack Cloud.

Federated Identity provides a way to securely use existing credentials
to access cloud resources such as servers, volumes, and databases,
across multiple endpoints provided in multiple authorized clouds using a
single set of credentials, without having to provision additional
identities or log in multiple times. The credential is maintained by the
user's Identity Provider.

Some important definitions:

Service Provider (SP)
    A system entity that provides services to principals or other system
    entities, in this case, OpenStack Identity is the Service Provider.

Identity Provider (IdP)
    A directory service, such as LDAP, RADIUS and Active Directory,
    which allows users to login with a user name and password, is a
    typical source of authentication tokens (e.g. passwords) at an
    :term:`identity provider`.

SAML assertion
    Contains information about a user as provided by an IdP. It is an
    indication that a user has been authenticated.

Mapping
    Adds a set of rules to map Federation protocol attributes to
    Identity API objects. An Identity Provider has exactly one mapping
    specified per protocol.

Protocol
    Contains information that dictates which Mapping rules to use for an
    incoming request made by an IdP. An IdP may support multiple
    protocols. There are three major protocols for
    :term:`federated identity`: OpenID, SAML, and OAuth.

Unscoped token
    Allows a user to authenticate with the Identity service to exchange
    the :term:`unscoped token` for a :term:`scoped token`, by providing
    a project ID or a domain ID.

Scoped token
    Allows a user to use all OpenStack services apart from the Identity
    service.

Why use Federated Identity?
~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  Provisioning new identities often incurs some security risk. It is
   difficult to secure credential storage and to deploy it with proper
   policies. A common identity store is useful as it can be set up
   properly once and used in multiple places. With Federated Identity,
   there is no longer a need to provision user entries in Identity
   service, since the user entries already exist in the IdP's databases.

   This does introduce new challenges around protecting that identity.
   However, this is a worthwhile tradeoff given the greater control, and
   fewer credential databases that come with a centralized common
   identity store.

-  It is a burden on the clients to deal with multiple tokens across
   multiple cloud service providers. Federated Identity provides single
   sign on to the user, who can use the credentials provided and
   maintained by the user's IdP to access many different services on the
   Internet.

-  Users spend too much time logging in or going through 'Forget
   Password' workflows. Federated identity allows for single sign on,
   which is easier and faster for users and requires fewer password
   resets. The IdPs manage user identities and passwords so OpenStack
   does not have to.

-  Too much time is spent administering identities in various service
   providers.

-  The best test of interoperability in the cloud is the ability to
   enable a user with one set of credentials in an IdP to access
   multiple cloud services. Organizations, each using its own IdP can
   easily allow their users to collaborate and quickly share the same
   cloud services.

-  Removes a blocker to cloud brokering and multi-cloud workload
   management. There is no need to build additional authentication
   mechanisms to authenticate users, since the IdPs take care of
   authenticating their own users using whichever technologies they deem
   to be appropriate. In most organizations, multiple authentication
   technologies are already in use.

Configuring Identity service for Federation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Federated users are not mirrored in the Identity service back end (for
example, using the SQL driver). The external IdP is responsible for
authenticating users, and communicates the result of the authentication
to Identity service using SAML assertions. Identity service maps the
SAML assertions to keystone user groups and assignments created in
Identity service.

Enabling Federation
-------------------

To enable Federation, perform the following steps:

#. Run the Identity service under Apache, instead of using
   ``keystone-all``.

   #. Enable TLS support. Install ``mod_nss`` according to your distribution,
      then apply the following patch and restart HTTPD:

      .. code:: diff

         --- /etc/httpd/conf.d/nss.conf.orig 2012-03-29 12:59:06.319470425 -0400
         +++ /etc/httpd/conf.d/nss.conf      2012-03-29 12:19:38.862721465 -0400
         @@ -17,7 +17,7 @@
         # Note: Configurations that use IPv6 but not IPv4-mapped addresses need two
         #       Listen directives: "Listen [::]:8443" and "Listen 0.0.0.0:443"
         #
         -Listen 8443
         +Listen 443

         ##
         ##  SSL Global Context
         @@ -81,7 +81,7 @@
         ## SSL Virtual Host Context
         ##

         -<virtualhost _default_:8443="">
         +<virtualhost _default_:443="">

         #   General setup for the virtual host
          #DocumentRoot "/etc/httpd/htdocs"
         </virtualhost></virtualhost>

   #. If you have a firewall in place, configure it to allow TLS traffic. For
      example:

      .. code:: console

         -A INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT

      Note this needs to be added before your reject all rule which might be:

      .. code:: console

         -A INPUT -j REJECT --reject-with icmp-host-prohibited

   #. Copy the ``httpd/wsgi-keystone.conf`` file to the appropriate location
      for your Apache server, for example,
      ``/etc/httpd/conf.d/wsgi-keystone.conf`` file.

   #. Create the directory ``/var/www/cgi-bin/keystone/``. Then link the files
      ``main`` and ``admin`` to the ``keystone.py`` file in this directory.

      For a distribution appropriate place, it should probably be copied to
      ``/usr/share/openstack/keystone/httpd/keystone.py``.

      .. note::

         This path is Ubuntu-specific. For other distributions, replace with
         appropriate path.

   #. If you are running with SELinux enabled ensure that the file has the
      appropriate SELinux context to access the linked file. For example, if
      you have the file in ``/var/www/cgi-bin`` location, you can do this by
      running:

      .. code:: console

         # restorecon /var/www/cgi-bin

      Adding it in a different location requires you set up your SELinux
      policy accordingly.

   #. Make sure you use either the SQL or the ``memcached`` driver for tokens,
      otherwise the tokens will not be shared between the processes of the
      Apache HTTPD server.

      For SQL, in ``/etc/keystone/keystone.conf`` , set:

      .. code:: ini

         [token]
         driver = sql

      For ``memcached``, in ``/etc/keystone/keystone.conf``, set:

      .. code:: ini

         [token]
         driver = memcache

      In both cases, all servers that are storing tokens need a shared back
      end. This means either that both point to the same database server, or
      both point to a common memcached instance.

   #. Install Shibboleth:

      .. code:: console

         # apt-get install libapache2-mod-shib2

      .. note::

         The ``apt-get`` command is Ubuntu specific. For other distributions,
         replace with appropriate command.

   #. Configure the Identity service virtual host and adjust the config to
      properly handle SAML2 workflow.

      Add ``WSGIScriptAlias`` directive to your vhost configuration:

      .. code:: ini

         WSGIScriptAliasMatch ^(/v3/OS-FEDERATION/identity_providers/.*?/protocols/.*?/auth)$ /var/www/keystone/main/$1

   #. Add two ``<Location>`` directives to the ``wsgi-keystone.conf`` file:

      .. code:: ini

         <Location /Shibboleth.sso>
         SetHandler shib
         </Location>

         <LocationMatch /v3/OS-FEDERATION/identity_providers/.*?/protocols/saml2/auth>
         ShibRequestSetting requireSession 1
         AuthType shibboleth
         ShibRequireAll On
         ShibRequireSession On
         ShibExportAssertion Off
         Require valid-user
         </LocationMatch>

      .. note::

         The option ``saml2`` may be different in your deployment, but do not
         use a wildcard value. Otherwise every Federated protocol will be
         handled by Shibboleth.

         The ``ShibRequireSession`` rule is invalid in Apache 2.4 or newer
         and should be dropped in that specific setup.

   #. Enable the Identity service virtual host:

      .. code:: console

         # a2ensite wsgi-keystone.conf

   #. Enable the ``ssl`` and ``shib2`` modules:

      .. code:: console

         # a2enmod ssl
         # a2enmod shib2

   #. Restart Apache:

      .. code:: console

         # service apache2 restart

      .. note::

         The ``service apache2 restart`` command is Ubuntu-specific. For
         other distributions, replace with appropriate command.

#. Configure Apache to use a Federation capable authentication method.

   #. Once you have your Identity service virtual host ready, configure
      Shibboleth and upload your metadata to the Identity Provider.

      If new certificates are required, they can be easily created by
      executing:

      .. code:: console

         $ shib-keygen -y NUMBER_OF_YEARS

      The newly created file will be stored under
      ``/etc/shibboleth/sp-key.pem``

   #. Upload your Service Provider’s metadata file to your Identity Provider.

   #. Configure your Service Provider by editing
      ``/etc/shibboleth/shibboleth2.xml``.

      For more information, see `Shibboleth Service Provider Configuration
      <https://wiki.shibboleth.net/confluence/display/SHIB2/Configuration>`__.

   #. Identity service enforces ``external`` authentication when environment
      variable ``REMOTE_USER`` is present so make sure Shibboleth does not set
      the ``REMOTE_USER`` environment variable. To do so, scan through the
      ``/etc/shibboleth/shibboleth2.xml`` configuration file and remove
      the ``REMOTE_USER`` directives.

   #. Examine your attributes map in the
      ``/etc/shibboleth/attributes-map.xml`` file and adjust your
      requirements if needed. For more information see `Shibboleth Attributes
      <https://wiki.shibboleth.net/confluence/display/SHIB2/NativeSPAddAttribute>`__.

   #. Restart the Shibboleth daemon:

      .. code:: console

         # service shibd restart
         # service apache2 restart

#. Enable ``OS-FEDERATION`` extension:

   #. Add the Federation extension driver to the ``[federation]`` section in
      the ``keystone.conf`` file. For example:

      .. code:: ini

         [federation]
         driver = sql

   #. Add the saml2 authentication method to the ``[auth]`` section in
      ``keystone.conf`` file:

      .. code:: ini

         [auth]
         methods = external,password,token,saml2
         saml2 = keystone.auth.plugins.saml2.Saml2

      .. note::

         The ``external`` method should be dropped to avoid any interference
         with some Apache and Shibboleth SP setups, where a ``REMOTE_USER``
         environment variable is always set, even as an empty value.

   #. Add the ``federation_extension`` middleware to the ``api_v3`` pipeline
      in the ``keystone-paste.ini`` file. For example:

      .. code:: ini

         [pipeline:api_v3]
         pipeline = access_log sizelimit url_normalize token_auth
         admin_token_auth xml_body json_body ec2_extension s3_extension
         federation_extension service_v3

   #. Create the Federation extension tables if using the provided SQL back
      end. For example:

      .. code:: console

         $ keystone-manage db_sync --extension federation

Ideally, to test that the Identity Provider and the Identity service are
communicating, navigate to the protected URL and attempt to sign in. If
you get a response back from keystone, even if it is a wrong response,
indicates the communication.

Configuring Federation
~~~~~~~~~~~~~~~~~~~~~~

Now that the Identity Provider and Identity service are communicating,
you can start to configure the ``OS-FEDERATION`` extension.

#. Create Identity groups and assign roles.

   No new users will be added to the Identity back end, but the Identity
   service requires group-based role assignments to authorize federated
   users. The Federation mapping function will map the user into local
   Identity service groups objects, and hence to local role assignments.

   Thus, it is required to create the necessary Identity service groups
   that correspond to the Identity Provider’s groups; additionally, these
   groups should be assigned roles on one or more projects or domains. For
   example, groups here refers to the Identity service groups that should
   be created so that when mapping from the SAML attribute ``Employees``,
   you can map it to a Identity service group ``devs``.

   The Identity service administrator can create as many groups as there
   are SAML attributes, whatever the mapping calls for.

#. Add Identity Providers, Mappings and Protocols.

   To utilize Federation, create the following in the Identity service:
   Identity Provider, Mapping, Protocol.

Performing Federation authentication
------------------------------------

#. Authenticate externally and generate an :term:`unscoped token` in
   Identity service.

   To start Federated authentication a user must access the dedicated URL
   with Identity Provider’s and Protocol’s identifiers stored within a
   protected URL. The URL has a format of:
   ``/v3/OS-FEDERATION/identity_providers/{identity_provider}/protocols/{protocol}/auth``.

   This instance follows a standard SAML2 authentication procedure, that
   is, the user will be redirected to the Identity Provider’s
   authentication webpage and be prompted for credentials. After
   successfully authenticating the user will be redirected to the Service
   Provider’s endpoint. If using a web browser, a token will be returned in
   XML format. As an alternative to using a web browser, you can use
   Enhanced Client or Proxy (ECP), which is available in the
   ``keystoneclient`` in the Identity service API.

   In the returned unscoped token, a list of Identity service groups the
   user belongs to will be included.

   For example, the following URL would be considered protected by
   ``mod_shib`` and Apache, as such a request made to the URL would be
   redirected to the Identity Provider, to start the SAML authentication
   procedure.

   .. code:: console

      # curl -X GET \
      -D - http://localhost:5000/v3/OS-FEDERATION/identity_providers/{identity_provider}/protocols/{protocol}/auth

   .. note::

      It is assumed that the ``keystone`` service is running on port
      ``5000``.

#. Determine accessible resources.

   By using the previously returned token, the user can issue requests to
   the list projects and domains that are accessible.

   -  List projects a federated user can access:
      ``GET /OS-FEDERATION/projects``

   -  List domains a federated user can access:
      ``GET /OS-FEDERATION/domains``

   For example,

   .. code:: console

      # curl -X GET \
      -H "X-Auth-Token: <unscoped token>" \
      http://localhost:5000/v3/OS-FEDERATION/projects

   or

   .. code:: console

      # curl -X GET \
      -H "X-Auth-Token: <unscoped token>" http://localhost:5000/v3/OS-FEDERATION/domains

#. Get a scoped token.

   A federated user may request a :term:`scoped token`, by using the unscoped
   token. A project or domain may be specified by either ID or name. An ID
   is sufficient to uniquely identify a project or domain. For example,

   .. code:: console

      # curl -X POST \
      -H "Content-Type: application/json" \
      -d '{"auth":{"identity":{"methods":["saml2"],"saml2":{"id":
      "<unscoped_token_id>"}},"scope":{"project":{"domain": {"name":
      "Default"},"name":"service"}}}}' \
      -D - http://localhost:5000/v3/auth/tokens

Setting Identity service as Identity Provider
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration options
---------------------

Before attempting to federate multiple Identity service deployments, you
must setup certain configuration options in the ``keystone.conf``
file.

Within the ``keystone.conf`` assign values to the ``[saml]`` related
fields, for example:

.. code:: ini

    [saml]
    certfile=/etc/keystone/ssl/certs/ca.pem
    keyfile=/etc/keystone/ssl/private/cakey.pem
    idp_entity_id=https://keystone.example.com/v3/OS-FEDERATION/saml2/idp
    idp_sso_endpoint=https://keystone.example.com/v3/OS-FEDERATION/saml2/sso
    idp_metadata_path=/etc/keystone/saml2_idp_metadata.xml

It is recommended that the following ``Organization`` configuration
options be setup.

.. code:: ini

    idp_organization_name=example_company
    idp_organization_display_name=Example Corp.
    idp_organization_url=example.com

It is also recommended the following ``Contact`` options are set.

.. code:: ini

    idp_contact_company=example_company
    idp_contact_name=John
    idp_contact_surname=Smith
    idp_contact_email=jsmith@example.com
    idp_contact_telephone=555-55-5555
    idp_contact_type=technical

Generate metadata
-----------------

In order to create a trust between the Identity Provider and the Service
Provider, metadata must be exchanged. To create metadata for your
Identity service, run the :command:`keystone-manage` command and pipe the
output to a file. For example:

.. code:: console

    $ keystone-manage saml_idp_metadata > /etc/keystone/saml2_idp_metadata.xml

.. note::

    The file location should match the value of the configuration option
    ``idp_metadata_path`` that was assigned in the list of ``[saml]``
    updates.

Create a region for the Service Provider
----------------------------------------

Create a new region for the :term:`service provider`, for example, create a
new region with an ``ID`` of BETA, and ``URL`` of
https://beta.com/Shibboleth.sso/SAML2/POST. This URL will be used when
creating a :term:`SAML assertion` for BETA, and signed by the current
keystone Identity Provider.

.. code:: console

    $ curl -s -X PUT \
      -H "X-Auth-Token: $OS_TOKEN" \
      -H "Content-Type: application/json" \
      -d '{"region": {"url": "http://beta.com/Shibboleth.sso/SAML2/POST"}}' \
      http://localhost:5000/v3/regions/BETA | python -mjson.tool

Testing it all out
------------------

Lastly, if a scoped token and a Service Provider region are presented to
keystone, the result will be a full SAML Assertion, signed by the IdP
keystone, specifically intended for the Service Provider keystone.

.. code:: console

    $ curl -s -X POST \
      -H "Content-Type: application/json" \
      -d '{"auth": {"scope": {"region": {"id": "BETA"}}, "identity": {"token": {"id": "d793d935b9c343f783955cf39ee7dc3c"}, "methods": ["token"]}}}' \
      http://localhost:5000/v3/auth/OS-FEDERATION/saml2

At this point the SAML Assertion can be sent to the Service Provider
keystone, and a valid OpenStack token, issued by a Service Provider
keystone, will be returned.

Future
~~~~~~

Currently, the CLI supports the Enhanced Client or Proxy (ECP), (the
non-browser) support for ``keystoneclient`` from an API perspective. So,
if you are using the ``keystoneclient``, you can create a client
instance and use the SAML authorization plugin. There is no support for
dashboard available presently. With the upcoming OpenStack releases,
Federated Identity should be supported with both CLI and the dashboard.
