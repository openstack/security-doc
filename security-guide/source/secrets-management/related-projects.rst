==========================
Related Openstack Projects
==========================

`Castellan <https://docs.openstack.org/castellan/latest/>`_ is a library that
provides a simple common interface to store, generate and retrieve secrets. It
is used by most Openstack services for secret management. As a library,
Castellan does not provide a secret store in and of itself. Rather, a back-end
implementation is required to be deployed.

Note that Castellan does not provide any authentication. It simply passes
through the authentication credentials (a Keystone token, for example) to the
back-end.

`Barbican <https://docs.openstack.org/barbican/latest/>`_ is an OpenStack service that provides a back-end for Castellan.
Barbican expects and authenticates a keystone authentication token to identify
the user and project accessing or storing a secret. It then applies policy to
determine if access is permitted. It also provides a number of additional
useful features to improve secret management including quotas, per-secret ACLs,
tracking of secret consumers and grouping of secrets in secret containers.
Octavia, for example, integrates directly with Barbican (instead of Castellan)
to take advantage of some of these features.

Barbican has a number of back-end plugins that can be used to securely store
secrets in local databases or in HSMs.

Currently, Barbican is the only available back-end for Castellan. There are,
however, several back-ends that are being developed, including KMIP, Dogtag,
Hashicorp Vault and Custodia. For those deployers who do not wish to deploy
Barbican and have relatively simple key management needs, using one of these
back-ends could be a viable alternative. What would be lacking though is
multi-tenancy and tenant-policy enforcement when retrieving the secrets, as
well as any of the extra features mentioned above.
