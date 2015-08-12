======
Tokens
======

Once a user is authenticated a token is generated for authorization and
access to an OpenStack environment. A token can have a variable life
span; however since the release of OpenStack Icehouse, the default value
for expiry has been reduced to one hour. The recommended expiry value
should be set to a lower value that allows enough time for internal
services to complete tasks. In the event that the token expires before
tasks complete, the cloud may become unresponsive or stop providing
services. An example of expended time during use would be the time
needed by the Compute service to transfer a disk image onto the
hypervisor for local caching.

The following example shows a PKI token. Note that token id values are
typically 3500 bytes. In this example, the value has been truncated.

.. code:: json

   {
       "token": {
           "expires": "2013-06-26T16:52:50Z",
           "id": "MIIKXAY...",
           "issued_at": "2013-06-25T16:52:50.622502",
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
