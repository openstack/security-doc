============
Case studies
============

Earlier in :doc:`../introduction/introduction-to-case-studies` we
introduced the Alice and Bob case studies where Alice is deploying a
private government cloud and Bob is deploying a public cloud each
with different security requirements. Here we discuss how Alice and
Bob would address dashboard configuration to secure their private and
public clouds. Alice's dashboard is not publicly accessible, but she
is still concerned about securing the administrative dashboard
against improper use. Bob's dashboard, being public, must take
measures to reduce the risk of attacks by external adversaries.

Alice's cloud running a public application
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On the new installation, Alice deploys Apache as the Web
Service Gateway Interface (WSGI) so that she can take advantage of
the health monitoring and clustering features of HAProxy, and keep
a homogeneous deployment in her environment. She modifies the
``SECURE_PROXY_SSL_HEADER`` variable and disables
front end caching with with the session cookies set to httponly to
apply HSTS protections, which decreases the risk of communication
being downgraded from TLS to HTTP. Such a downgrade would be more
vulnerable to a 'man in the middle' (MITM) attack. As her
application is public facing, Alice creates an internal domain for
the dashboard access and issues internal PKI certificates.

Alice disables image uploading in the OpenStack dashboard
(horizon) as application users will not need this feature, and
management users will be uploading purpose-built images. As these
images will be sufficiently large, using the OpenStack Image
service (glance) upload features directly will be more efficient
than doing so through the dashboard, and her team has the required
access to the Image service. She uploads her divisions logo into
the dashboard page, but leaves the rest of the dashboard default
taking care not to add additional programs or features that may
introduce additional vulnerabilities.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

Bob expects the dashboard to be one of the main methods of interaction
users will have with their cloud, and as such he deploys the latest
version of Nginx that has integrated active-passive high-availability
based on keepalived. He makes sure that his networking configuration is
configured to handle VRRP (used by keepalived), sets unique values
for the `virtual_router_id` in the Nginx configuration file, determines
which instance will start as master, and upates the proper values for
the `unicast_src_ip` and `unicast_peer` setttings. He makes sure that
both instances have their own copy of the configuration file and the
`chk_nginx_service` script is configured to ensure the instances are
validating the local node's priority.

Bob then enables HSTS by adding a new response header in the Nginx
server block, substituting applicable values for <NAME> and <TIME>:

.. code:: console

   server{
   listen 443 ssl;
   sever_name <NAME>
   add_header Strict-Transport-Security "max-age=<TIME>; includeSubdomains";

Bob also disables image uploading in the Dashboard as well as the Image
service, as customers with custom images will go through Bob's service
team for additional assurance. He updates the Dashboard with the
company logo, and includes several additional scripts to add
functionality, such as the ability to start a conversation with the help
desk. Bob also adds IDS rules to trigger on log messages that may
indicate security issues such as login bruteforcing or attempted
CSRF/XSS injections.
