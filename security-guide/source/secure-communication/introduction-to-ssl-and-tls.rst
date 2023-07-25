===========================
Introduction to TLS and SSL
===========================

There are situations where there is a security requirement to
assure the confidentiality or integrity of network traffic
in an OpenStack deployment. This is generally achieved using
cryptographic measures, such as the Transport Layer Security (TLS)
protocol.

In a typical deployment all traffic transmitted over public
networks is secured, but security best practice dictates that
internal traffic must also be secured. It is insufficient to rely
on security domain separation for protection. If an attacker
gains access to the hypervisor or host resources, compromises an
API endpoint, or any other service, they must not be able to
easily inject or capture messages, commands, or otherwise affect
the management capabilities of the cloud.

All domains should be secured with TLS, including the management
domain services and intra-service communications. TLS provides the
mechanisms to ensure authentication, non-repudiation,
confidentiality, and integrity of user communications to the
OpenStack services and between the OpenStack services themselves.

Due to the published vulnerabilities in the Secure Sockets Layer
(SSL) protocols, we strongly recommend that TLS is used in preference
to SSL, and that SSL is disabled in all cases, unless compatibility
with obsolete browsers or libraries is required.

Public Key Infrastructure (PKI) is the framework for securing
communication in a network. It consists of a set of systems and
processes to ensure traffic can be sent securely while validating
the identity of the parties. The PKI profile described here
is the Internet Engineering Task Force (:term:`IETF`) Public Key
Infrastructure (PKIX) profile developed by the PKIX working group.
The core components of PKI are:

Digital Certificates
    Signed public key certificates are data structures that have
    verifiable data of an entity, its public key along with some
    other attributes. These certificates are issued by a
    Certificate Authority (CA). As the certificates are signed by
    a CA that is trusted, once verified, the public key associated
    with the entity is guaranteed to be associated with the said entity.
    The most common standard used to define these certificates is the
    :term:`X.509` standard. The :term:`X.509` v3 which is the
    current standard is described in detail in `RFC5280 <http://tools.ietf.org/html/5280>`_.
    Certificates are issued by CAs as a mechanism to prove the identity
    of online entities. The CA digitally signs the certificate by
    creating a message digest from the certificate and encrypting the
    digest with its private key.

End entity
    User, process, or system that is the subject of a certificate. The
    end entity sends its certificate request to a Registration Authority
    (RA) for approval. If approved, the RA forwards the request to a
    Certification Authority (CA). The Certification Authority verifies the
    request and if the information is correct, a certificate is generated
    and signed. This signed certificate is then send to a Certificate
    Repository.

Relying party
    The endpoint that receives the digitally signed certificate that is
    verifiable with reference to the public key listed on the certificate.
    The relying party should be in a position to verify the certificate up
    the chain, ensure that it is not present in the :term:`CRL` and also
    must be able to verify the expiry date on the certificate.

Certification Authority (:term:`CA <certificate authority (CA)>`)
    CA is a trusted entity, both by the end party and the party that relies
    upon the certificate for certification policies, management handling,
    and certificate issuance.

Registration Authority (RA)
    An optional system to which a CA delegates certain management functions,
    this includes functions such as, authentication of end entities before they
    are issued a certificate by a CA.

Certificate Revocation Lists (CRL)
   A Certificate Revocation List (CRL) is a list of certificate serial numbers
   that have been revoked. End entities presenting these certificates should
   not be trusted in a PKI model. Revocation can happen because of several
   reasons for example, key compromise, CA compromise.

CRL issuer
    An optional system to which a CA delegates the publication of certificate
    revocation lists.

Certificate Repository
    Where the end entity certificates and certificate revocation lists are
    stored and looked up - sometimes referred to as the *certificate
    bundle*.

PKI builds the framework on which to provide encryption algorithms,
cipher modes, and protocols for securing data and authentication. We
strongly recommend securing all services with Public Key Infrastructure
(PKI), including the use of TLS for API endpoints. It is impossible for
the encryption or signing of transports or messages alone to solve all
these problems. Hosts themselves must be secure and implement policy,
namespaces, and other controls to protect their private credentials and
keys. However, the challenges of key management and protection do not
reduce the necessity of these controls, or lessen their importance.

Certification authorities
~~~~~~~~~~~~~~~~~~~~~~~~~

Many organizations have an established Public Key Infrastructure with
their own Certification Authority (CA), certificate policies, and
management for which they should use to issue certificates for internal
OpenStack users or services. Organizations in which the public security
domain is Internet facing will additionally need certificates signed by a
widely recognized public CA. For cryptographic communications over the
management network, it is recommended one not use a public CA. Instead,
we expect and recommend most deployments deploy their own internal CA.

It is recommended that the OpenStack cloud architect consider using
separate PKI deployments for internal systems and customer facing
services. This allows the cloud deployer to maintain control of their
PKI infrastructure and among other things makes requesting, signing and
deploying certificates for internal systems easier. Advanced
configurations may use separate PKI deployments for different security
domains. This allows deployers to maintain cryptographic separation of
environments, ensuring that certificates issued to one are not
recognized by another.

Certificates used to support TLS on internet facing cloud endpoints
(or customer interfaces where the customer is not expected to have
installed anything other than standard operating system provided
certificate bundles) should be provisioned using Certificate
Authorities that are installed in the operating system certificate
bundle. Typical well known vendors include Let's Encrypt, Verisign
and Thawte but many others exist.

There are management, policy, and technical challenges around
creating and signing certificates. This is an area where cloud
architects or operators may wish to seek the advice of industry leaders
and vendors in addition to the guidance recommended here.

TLS libraries
~~~~~~~~~~~~~

Components, services, and applications within the OpenStack
ecosystem or dependencies of OpenStack are implemented or can be
configured to use TLS libraries. The TLS and HTTP services within
OpenStack are typically implemented using OpenSSL which has a module
that has been validated for FIPS 140-2. However, keep in mind that each
application or service can still introduce weaknesses in how they use
the OpenSSL libraries.

Cryptographic algorithms, cipher modes, and protocols
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We recommend that a minimum of TLS 1.2 be used. Older versions such as
TLS 1.0, 1.1, and all versions of SSL (TLS's predecessor) are vulnerable to
multiple publicly known attacks and therefore must not be used. TLS 1.2 may be
used for broad client compatibility, however exercise caution when enabling
this protocol. Only enable TLS version 1.1 if there is a mandatory
compatibility requirement and you are aware of the risks involved.

When you are using TLS 1.2 and control both the clients and
the server, the cipher suite should be limited to
``ECDHE-ECDSA-AES256-GCM-SHA384``. In circumstances where you do not
control both endpoints and are using TLS 1.1 or 1.2 the more general
``HIGH:!aNULL:!eNULL:!DES:!3DES:!SSLv3:!TLSv1:!CAMELLIA`` is a
reasonable cipher selection.

However, as this book does not intend to be a thorough reference on
cryptography we do not wish to be prescriptive about what specific
algorithms or cipher modes you should enable or disable in your
OpenStack services. There are some authoritative references
we would like to recommend for further information:

* `National Security Agency, Suite B Cryptography <http://www.nsa.gov/ia/programs/suiteb_cryptography/index.shtml>`_
* `OWASP Guide to Cryptography <https://www.owasp.org/index.php/Guide_to_Cryptography>`_
* `OWASP Transport Layer Protection Cheat Sheet <https://www.owasp.org/index.php/Transport_Layer_Protection_Cheat_Sheet>`_
* `SoK: SSL and HTTPS: Revisiting past challenges and evaluating certificate trust model enhancements <http://www.ieee-security.org/TC/SP2013/papers/4977a511.pdf>`_
* `The Most Dangerous Code in the World: Validating SSL Certificates in Non-Browser Software <http://www.cs.utexas.edu/~shmat/shmat_ccs12.pdf>`_
* `OpenSSL and FIPS 140-2 <https://www.openssl.org/docs/fips.html>`_

Summary
~~~~~~~

Given the complexity of the OpenStack components and the
number of deployment possibilities, you must take care to
ensure that each component gets the appropriate configuration
of TLS certificates, keys, and CAs. Subsequent sections discuss
the following services:

* Compute API endpoints
* Identity API endpoints
* Networking API endpoints
* Storage API endpoints
* Messaging server
* Database server
* Dashboard
