=============
Authorization
=============

The Identity service supports the notion of groups and roles. Users
belong to groups while a group has a list of roles. OpenStack services
reference the roles of the user attempting to access the service. The
OpenStack policy enforcer middleware takes into consideration the policy
rule associated with each resource then the user's group/roles and
association to determine if access is allowed to the requested resource.

The policy enforcement middleware enables fine-grained access control to
OpenStack resources. Only admin users can provision new users and have
access to various management functionality. The cloud users would only
be able to spin up instances, attach volumes, and perform other
operational tasks.

Establish formal access control policies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Prior to configuring roles, groups, and users, document your required
access control policies for the OpenStack installation. The policies
should be consistent with any regulatory or legal requirements for the
organization. Future modifications to the access control configuration
should be done consistently with the formal policies. The policies
should include the conditions and processes for creating, deleting,
disabling, and enabling accounts, and for assigning privileges to the
accounts. Periodically review the policies and ensure that the
configuration is in compliance with approved policies.

Service authorization
~~~~~~~~~~~~~~~~~~~~~

Cloud administrators must define a user with the role of admin for each
service, as described in the `OpenStack Cloud Administrator
Guide <http://docs.openstack.org/admin-guide-cloud/index.html>`__.
This service account provides the service with the authorization to
authenticate users.

The Compute and Object Storage services can be configured to use the
Identity service to store authentication information. Other options to
store authentication information include the use of the "tempAuth" file,
however this should not be deployed in a production environment as the
password is displayed in plain text.

The Identity service supports client authentication for TLS which may be
enabled. TLS client authentication provides an additional authentication
factor, in addition to the user name and password, that provides greater
reliability on user identification. It reduces the risk of unauthorized
access when user names and passwords may be compromised. However, there
is additional administrative overhead and cost to issue certificates to
users that may not be feasible in every deployment.

.. note::

    We recommend that you use client authentication with TLS for the
    authentication of services to the Identity service.

The cloud administrator should protect sensitive configuration files
from unauthorized modification. This can be achieved with mandatory
access control frameworks such as SELinux, including
``/etc/keystone/keystone.conf`` and X.509 certificates.

Client authentication with TLS requires certificates be issued to
services. These certificates can be signed by an external or internal
certificate authority. OpenStack services check the validity of
certificate signatures against trusted CAs by default and connections
will fail if the signature is not valid or the CA is not trusted. Cloud
deployers may use self-signed certificates. In this case, the validity
check must be disabled or the certificate should be marked as trusted.
To disable validation of self-signed certificates, set
``insecure=False`` in the ``[filter:authtoken]`` section in the
:file:`/etc/nova/api.paste.ini` file. This setting also disables
certificates for other components.

Administrative users
~~~~~~~~~~~~~~~~~~~~

We recommend that admin users authenticate using Identity service and an
external authentication service that supports 2-factor authentication,
such as a certificate. This reduces the risk from passwords that may be
compromised. This recommendation is in compliance with NIST 800-53
IA-2(1) guidance in the use of multi-factor authentication for network
access to privileged accounts.

End users
~~~~~~~~~

The Identity service can directly provide end-user authentication, or
can be configured to use external authentication methods to conform to
an organization's security policies and requirements.
