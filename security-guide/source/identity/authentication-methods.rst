======================
Authentication methods
======================

.. _internally-implemented-authentication-methods:

Internally implemented authentication methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Identity service can store user credentials in an SQL Database, or
may use an LDAP-compliant directory server. The Identity database may be
separate from databases used by other OpenStack services to reduce the
risk of a compromise of the stored credentials.

When you use a user name and password to authenticate, Identity does not
enforce policies on password strength, expiration, or failed
authentication attempts as recommended by NIST Special Publication
800-118 (draft). Organizations that desire to enforce stronger password
policies should consider using Identity extensions or external
authentication services.

LDAP simplifies integration of Identity authentication into an
organization's existing directory service and user account management
processes.

Authentication and authorization policy in OpenStack may be delegated to
another service. A typical use case is an organization that seeks to
deploy a private cloud and already has a database of employees and users
in an LDAP system. Using this as the authentication authority, requests
to the Identity service are delegated to the LDAP system, which will
then authorize or deny based on its policies. Upon successful
authentication, the Identity service then generates a token that is used
for access to authorized services.

Note that if the LDAP system has attributes defined for the user such as
admin, finance, HR etc, these must be mapped into roles and groups
within Identity for use by the various OpenStack services. The
``/etc/keystone/keystone.conf`` file maps LDAP attributes to Identity
attributes.

The Identity service **MUST NOT** be allowed to write to LDAP services
used for authentication outside of the OpenStack deployment as this
would allow a sufficiently privileged keystone user to make changes to
the LDAP directory. This would allow privilege escalation within the
wider organization or facilitate unauthorized access to other
information and resources. In such a deployment, user provisioning would
be out of the realm of the OpenStack deployment.

.. note::

    There is an `OpenStack Security Note (OSSN) regarding keystone.conf
    permissions <https://bugs.launchpad.net/ossn/+bug/1168252>`__.

    There is an `OpenStack Security Note (OSSN) regarding potential DoS
    attacks <https://bugs.launchpad.net/ossn/+bug/1155566>`__.

External authentication methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Organizations may desire to implement external authentication for
compatibility with existing authentication services or to enforce
stronger authentication policy requirements. Although passwords are the
most common form of authentication, they can be compromised through
numerous methods, including keystroke logging and password compromise.
External authentication services can provide alternative forms of
authentication that minimize the risk from weak passwords.

These include:

Password policy enforcement
  Requires user passwords to conform to minimum standards for length,
  diversity of characters, expiration, or failed login attempts. In an
  external authentication scenario this would be the password policy on
  the original identity store.

Multi-factor authentication
  The authentication service requires the user to provide information
  based on something they have, such as a one-time password token or
  X.509 certificate, and something they know, such as a password.

Kerberos
  A mutual authentication network protocol using 'tickets' to secure
  communication between client and server. The Kerberos ticket-granting
  ticket can be used to securely provide tickets for a given service.
