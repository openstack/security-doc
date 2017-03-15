====================
Secure communication
====================

Inter-device communication is a serious security concern.
Between large project errors, such as Heartbleed, or more
advanced attacks such as BEAST and CRIME, secure methods of
communication over a network are becoming more important. It should
be remembered, however that encryption should be applied as one part
of a larger security strategy. The compromise of an endpoint means
that an attacker no longer needs to break the encryption used, but
is able to view and manipulate messages as they are processed by
the system.

This chapter will review several features around configuring TLS to
secure both internal and external resources, and will call out
specific categories of systems that should be given specific
attention.

.. toctree::
   :maxdepth: 2

   secure-communication/introduction-to-ssl-and-tls.rst
   secure-communication/tls-proxies-and-http-services.rst
   secure-communication/secure-reference-architectures.rst
   secure-communication/case-studies.rst
