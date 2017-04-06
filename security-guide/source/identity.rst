========
Identity
========

Identity service (keystone) provides identity, token, catalog, and
policy services for use specifically by services in the OpenStack
family. Identity service is organized as a group of internal services
exposed on one or many endpoints. Many of these services are used in a
combined fashion by the front end. For example, an authentication call
validates user and project credentials with the identity service.
If successful, it will create and return a token with the token service.
More information can be found by reading the `keystone Developer
Documentation <https://docs.openstack.org/developer/keystone/index.html>`_.

.. toctree::
   :maxdepth: 2

   identity/authentication.rst
   identity/authentication-methods.rst
   identity/authorization.rst
   identity/policies.rst
   identity/tokens.rst
   identity/domains.rst
   identity/federated-keystone.rst
   identity/checklist.rst
.. case-studies/identity-case-studies.rst
