==============
Authentication
==============

Authentication is an integral part of any real world OpenStack
deployment and so careful thought should be given to this aspect of
system design. A complete treatment of this topic is beyond the scope of
this guide however some key topics are presented in the following
sections.

At its most basic, authentication is the process of confirming identity
- that a user is actually who they claim to be. A familiar example is
providing a username and password when logging in to a system.

The OpenStack Identity service (keystone) supports multiple methods of
authentication, including user name & password, LDAP, and external
authentication methods. Upon successful authentication, The Identity
service provides the user with an authorization token used for
subsequent service requests.

Transport Layer Security (TLS) provides authentication between services
and persons using X.509 certificates. Although the default mode for TLS
is server-side only authentication, certificates may also be used for
client authentication.

Invalid login attempts
~~~~~~~~~~~~~~~~~~~~~~

.. TODO (pdesai) fix link to introduction by adding link to Attack Types

The Identity service does not provide a method to limit access to
accounts after repeated unsuccessful login attempts. A pattern of
repetitive failed login attempts is generally an indicator of
brute-force attacks (refer to :doc:`../introduction`). This type of
attack is more prevalent in public cloud deployments.

Prevention is possible by using an external authentication system that
blocks out an account after some configured number of failed login
attempts. The account then may only be unlocked with further
side-channel intervention.

If prevention is not an option, detection can be used to mitigate
damage. Detection involves frequent review of access control logs to
identify unauthorized attempts to access accounts. Possible remediation
would include reviewing the strength of the user password, or blocking
the network source of the attack through firewall rules. Firewall rules
on the keystone server that restrict the number of connections could be
used to reduce the attack effectiveness, and thus dissuade the attacker.

In addition, it is useful to examine account activity for unusual login
times and suspicious actions, and take corrective actions such as
disabling the account. Oftentimes this approach is taken by credit card
providers for fraud detection and alert.

Multi-factor authentication
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Employ multi-factor authentication for network access to privileged user
accounts. The Identity service supports external authentication services
through the Apache web server that can provide this functionality.
Servers may also enforce client-side authentication using certificates.

This recommendation provides insulation from brute force, social
engineering, and both spear and mass phishing attacks that may
compromise administrator passwords.
