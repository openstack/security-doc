========
Identity
========

Identity service (keystone) provides identity, token, catalog, and
policy services for use specifically by services in the OpenStack
family. Identity service is organized as a group of internal services
exposed on one or many endpoints. Many of these services are used in a
combined fashion by the frontend, for example an authenticate call will
validate user/project credentials with the identity service and, upon
success, create and return a token with the token service. Further
information can be found by reading the `Keystone Developer
Documentation <https://docs.openstack.org/developer/keystone/index.html>`__.

.. toctree::
   :maxdepth: 2

   identity/authentication.rst
   identity/authentication-methods.rst
   identity/authorization.rst
   identity/policies.rst
   identity/tokens.rst
   identity/domains.rst
   identity/federated-keystone.rst
   identity/case-studies.rst
   identity/checklist.rst
