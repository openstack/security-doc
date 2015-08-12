============
Case studies
============

Earlier in :doc:`../introduction/introduction-to-case-studies` we
introduced the Alice and Bob case study where Alice is deploying a
government cloud and Bob is deploying a public cloud each with
different security requirements. Here we discuss how Alice and Bob
would address deployment of PKI certification authorities (CA) and
certificate management.

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

After looking through the secure communication controls of
both FedRAMP/FISMA and HIPAA, Alice decides to have all the
systems use TLS 1.1 or greater, with export ciphers, the RC4
encryption algorithm, and all versions of SSL disabled. She
registers the website through a certificate signing company and
validates her identity and workplace to get a public
certificate. This is then added to the web application so that
incoming clients will be able to use TLS. Internally, she
configures a PKI infrastructure to failover across availability
zones, and bundles the trust certificate into each golden
image's certificate store so that new images will be able to use
the certificate upon creation. She also notes in the golden
image update policy that the certificate will need to be rotated
in the image and on running instances before the expiration
date. She also validates that HSTS is enabled on all web servers
and other protections outlined in the Dashboard chapter.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

Bob is architecting a public cloud and needs to ensure that the
publicly facing OpenStack services are using certificates issued by a
major public CA. Bob acquires certificates for his public OpenStack
services and configures the services to use PKI and TLS and includes
the public CAs in his trust bundle for the services. Additionally, Bob
also wants to further isolate the internal communications amongst the
services within the management security domain. Bob contacts the team
within his organization that is responsible for managing his
organization's PKI and issuance of certificates using their own
internal CA. Bob obtains certificates issued by this internal CA and
configures the services that communicate within the management security
domain to use these certificates and configures the services to only
accept client certificates issued by his internal CA.
