===========================
Introduction to TLS and SSL
===========================

There are a number of situations where there is a security
requirement to assure the confidentiality or integrity of
network traffic in an OpenStack deployment. This is generally
achieved using cryptographic measures, such as the Transport
Layer Security (TLS) protocol.

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
the identities of the parties. The core components of PKI are:

End entity
    User, process, or system that is the subject of a certificate.

Certification Authority (:term:`CA`)
    Defines certificate policies, management, and issuance of certificates.

Registration Authority (RA)
    An optional system to which a CA delegates certain management functions.

Repository
    Where the end entity certificates and certificate revocation lists are
    stored and looked up - sometimes referred to as the *certificate
    bundle*.

Relying party
    The endpoint that is trusting that the CA is valid.

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
their own certification authority (CA), certificate policies, and
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
bundle. Typical well known vendors include Verisign and Thawte but many
others exist.

There are many management, policy, and technical challenges around
creating and signing certificates. This is an area where cloud
architects or operators may wish to seek the advice of industry leaders
and vendors in addition to the guidance recommended here.

TLS libraries
~~~~~~~~~~~~~

Various components, services, and applications within the OpenStack
ecosystem or dependencies of OpenStack are implemented and can be
configured to use TLS libraries. The TLS and HTTP services within
OpenStack are typically implemented using OpenSSL which has a module
that has been validated for FIPS 140-2. However, keep in mind that each
application or service can still introduce weaknesses in how they use
the OpenSSL libraries.

Cryptographic algorithms, cipher modes, and protocols
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We recommend that only TLS 1.2 is used. Other versions such as
TLS 1.0 and 1.1 are vulnerable to multiple attacks. TLS 1.0 should be
disabled completely in your environment. TLS 1.1 may be used for broad
client compatibility, however, excercise caution when enabling this
protocol. Only enable TLS version 1.1 if there is a mandatory
requirement and you are aware of the risks involved. Older versions
of TLS should not be used as these versions include SSLv2 which is
deprecated, and SSLv3 which suffers from the attack known as POODLE.
When you are using TLS 1.2 and in control of both the clients and
the server, the cipher suite should be limited to
``ECDHE-ECDSA-AES256-GCM-SHA384``. In circumstances where you don’t
control both ends and are using TLS 1.1 or 1.2 the more general
``HIGH:!aNULL:!eNULL:!DES:!3DES:!SSLv3:!TLSv1:!CAMELLIA`` is a
reasonable cipher selection.

However, as this book does not intend to be a thorough reference on
cryptography we do not wish to be prescriptive about what specific
algorithms or cipher modes you should enable or disable in your
OpenStack services. However, there are some authoritative references
we would like to recommend for further information:

* `National Security Agency, Suite B Cryptography <http://www.nsa.gov/ia/programs/suiteb_cryptography/index.shtml>`_
* `OWASP Guide to Cryptography <https://www.owasp.org/index.php/Guide_to_Cryptography>`_
* `OWASP Transport Layer Protection Cheat Sheet <https://www.owasp.org/index.php/Transport_Layer_Protection_Cheat_Sheet>`_
* `SoK: SSL and HTTPS: Revisiting past challenges and evaluating certificate trust model enhancements <http://www.ieee-security.org/TC/SP2013/papers/4977a511.pdf>`_
* `The Most Dangerous Code in the World: Validating SSL Certificates in Non-Browser Software <http://www.cs.utexas.edu/~shmat/shmat_ccs12.pdf>`_
* `OpenSSL and FIPS 140-2 <http://www.openssl.org/docs/fips/fipsnotes.html>`_

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
