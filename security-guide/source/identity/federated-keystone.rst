==================
Federated keystone
==================

Some important definitions:

Service Provider (SP)
    A system entity that provides services to principals or other system
    entities, in this case, OpenStack Identity is the Service Provider.

Identity Provider (IdP)
    A directory service, such as LDAP, RADIUS and Active Directory,
    which allows users to login with a user name and password, is a
    typical source of authentication tokens (e.g. passwords) at an
    :term:`identity provider`.

:term:`Federated Identity<federated identity>` is a mechanism to
establish trusts between IdPs and SPs, in this case, between Identity
Providers and the services provided by an OpenStack Cloud. It provides a
secure way to use existing credentials to access cloud resources such as
servers, volumes, and databases, across multiple endpoints. The credential
is maintained by the user's IdP.

Why use Federated Identity?
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Two underlying reasons:

1) Reduced complexity makes your deployment easier to secure.
2) It saves time for you and your users.

-  Centralize account management to prevent duplication of effort inside
   OpenStack infrastructure.

-  Reduce burden on users. Single sign on lets a single authentication method
   be used to access many different services & environments.

-  Move responsibility of password recovery process to IdP.

Futher justification and details can be found in Keystone's `documentation
on federation <https://docs.openstack.org/keystone/latest/admin/federation/introduction.html>`_.
