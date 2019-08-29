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
hypervisor for local caching. Fetching expired tokens when using
a valid service token is allowed.

The token is often passed within the structure of a larger context of an
Identity service response. These responses also provide a catalog of the
various OpenStack services. Each service is listed with its name, access
endpoints for internal, admin, and public access.

Tokens can be revoked using the identity API.

In the Stein release, there are two supported token types:
fernet and JWT.

Neither fernet or JWT tokens require persistence. The keystone token database
no longer suffers bloat as a side effect of authentication. Pruning of expired
tokens happens automatically. Replication across multiple nodes is also no
longer needed. As long as each keystone node shares the same repository, tokens
can be created and validated instantly across all nodes.

Fernet tokens
~~~~~~~~~~~~~
Fernet tokens are the supported token provider for Stein (default). Fernet
is a secure messaging format explicitly designed for use in API tokens. They
are lightweight (fall in range of 180 to 240 bytes) and reduce the operational
overhead required to run a cloud. Authentication and authorization metadata is
neatly bundled into a message packed payload, which is then encrypted and
signed in as a fernet token.

JWT tokens
~~~~~~~~~~~~~
JSON Web Signature (JWS) tokens were introduced in the Stein release. Compared
to fernet, JWS offer a potential benefit to operators by limiting the number of
hosts that need to share a symmetric encryption key. This helps prevent
malicious actors who might already have a foothold in your deployment from
spreading into additional nodes.

Further details on the differences between these token providers can be found
here https://docs.openstack.org/keystone/stein/admin/tokens-overview.html#token-providers
