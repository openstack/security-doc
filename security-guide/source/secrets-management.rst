.. _secrets-management:

==================
Secrets Management
==================

Operators protect sensitive information in cloud deployments by using various
applications of cryptography. For example, encrypting data at rest or signing
an image to prove that it has not been tampered with. In all cases, these
cryptographic capabilities require some sort of *key material* in order to
operate.

Secrets Management describes a group of technologies that are designed to
protect key materials within a software system. Traditionally, key management
involves deployment of `Hardware Security Modules (HSM) <https://en.wikipedia.org/wiki/Hardware_security_module>`_.
These devices have been physically hardened against tampering.

As technology has advanced the number of secret things that need to be
protected has increased beyond key materials to include certificate pairs, API
keys, system passwords, signing keys and so on. This increase has created a
need for a more scalable approach to key management, and resulted in the
creation of a number of software services that provide scalable dynamic
key management. This chapter describes the services that exist today
and focus on those that are able to be integrated into OpenStack clouds.

.. toctree::
   :maxdepth: 2

   secrets-management/summary-of-technologies.rst
   secrets-management/related-projects.rst
   secrets-management/secrets-management-use-cases.rst
   secrets-management/barbican.rst
   secrets-management/castellan.rst
   secrets-management/faq.rst
   secrets-management/checklist.rst
