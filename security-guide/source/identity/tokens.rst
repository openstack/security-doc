======
Tokens
======

Once a user is authenticated, a token is generated for authorization and
access to an OpenStack environment. A token can have a variable life
span; however the default value for expiry is one hour. The recommended
expiry value should be set to a lower value that allows enough time for
internal services to complete tasks. In the event that the token expires
before tasks complete, the cloud may become unresponsive or stop providing
services. An example of expended time during use would be the time
needed by the Compute service to transfer a disk image onto the
hypervisor for local caching.

The following example shows a PKI token. Note that token id values are
typically 3500 bytes. In this example, the value has been truncated.

.. code:: json

   {
       "token": {
           "expires": "2015-10-15T16:52:50Z",
           "id": "MIIKXAY...",
           "issued_at": "2015-10-15T16:52:50.622502",
           "tenant": {
               "description": null,
               "enabled": true,
               "id": "912426c8f4c04fb0a07d2547b0704185",
               "name": "demo"
           }
       }
   }

The token is often passed within the structure of a larger context of an
Identity service response. These responses also provide a catalog of the
various OpenStack services. Each service is listed with its name, access
endpoints for internal, admin, and public access.

The Identity service supports token revocation. This manifests as an API
to revoke a token, to list revoked tokens and individual OpenStack
services that cache tokens to query for the revoked tokens and remove
them from their cache and append the same to their list of cached
revoked tokens.

In OpenStack Newton release, there are four supported token types:
UUID, PKI, PKIZ and fernet. Since OpenStack Ocata release, there are
two supported token types: UUID and fernet.

UUID tokens
~~~~~~~~~~~
UUID tokens are persistent tokens. UUID tokens are 32 bytes in length
and must be persisted in the back-end. They are stored in the Identity
service back-end along with the metadata for authentication. Clients
must pass their UUID token to the Identity service in order to validate it.
According to the release notes for Pike(see `release notes
<https://docs.openstack.org/releasenotes/keystone/pike.html#deprecation-notes>`_),
UUID token provider is being deprecated in favor of Fernet tokens.

PKI and PKIZ tokens
~~~~~~~~~~~~~~~~~~~
PKI and PKIZ tokens are deprecated and not supported in Ocata. They are
nearly identical and share the same payload. They are signed documents
that contain the authentication content, as well as the service catalog.
Depending on the size of the OpenStack deployment, PKI tokens can be very
long. PKI and PKIZ tokens typically exceed 1600 bytes length. The length
of a PKI or PKIZ token is dependent on the size of the deployment. Bigger
service catalogs will result in longer token lengths. The Identity service
uses public and private key pairs and certificates in order to create and
validate these tokens. The difference between the two is PKIZ tokens are
compressed to help mitigate the size issues of PKI.

Fernet tokens
~~~~~~~~~~~~~
Fernet tokens are the supported token provider for Pike (default). Fernet
is a secure messaging format explicitly designed for use in API tokens.
They are non-persistent (no need to be persisted to a database), lightweight
(fall in range of 180 to 240 bytes) and reduce the operational overhead
required to run a cloud. Authentication and authorization metadata is neatly
bundled into a message packed payload, which is then encrypted and signed in
as a fernet token.

Unlike UUID, PKI and PKIZ tokens, fernet tokens do not require persistence.
The keystone token database no longer suffers bloat as a side effect of
authentication. Pruning expired tokens from the token database is no longer
required when using fernet tokens. Since fernet tokens are non-persistent,
they do not have to be replicated. As long as each keystone node shares the
same repository, fernet tokens can be created and validated instantly across
nodes.

Compared to PKI and PKIZ tokens, fernet tokens are smaller in size; usually
kept under a 250 byte limit. For PKI and PKIZ tokens, bigger service catalogs
will result in longer token lengths. This pattern does not exist with fernet
tokens because the contents of the encrypted payload is kept to minimum.
