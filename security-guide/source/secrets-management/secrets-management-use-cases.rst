=========
Use Cases
=========

Image signature verification
----------------------------

Verification of image signatures assures that an image is not replaced or
changed since the time of original upload. The image signature verification
feature uses Castellan as its key manager for storing cryptographic signatures.
An image signature and certificate UUID is uploaded along with the image to the
Image (glance) service. Glance verifies the signature after retrieving the
certificate from the key manager. When the image is booted, the Compute
service (nova) verifys the signature after it retrieves the certificate from
the key manager.

For more details, see the `Trusted Images documentation
<https://docs.openstack.org/security-guide/instance-management/security-services-for-instances.html#trusted-images/>`_.

Volume encryption
-----------------

The volume encryption feature provides encryption of data-at-rest using
Castellan. When a user creates an encrypted volume type, and creates a
volume using that type, the Block Storage (cinder) service requests the key
manager to create a key to be associated with that volume. When the volume is
attached to an instance, nova retrieves the key.

For more details, see the `Data Encryption section <https://docs.openstack.org/security-guide/tenant-data/data-encryption.html>`_.
and `Volume encryption <https://docs.openstack.org/ocata/config-reference/block-storage/volume-encryption.html>`_.

Ephemeral disk encryption
-------------------------

The ephemeral disk encryption feature addresses data privacy. The
ephemeral disk is a temporary work space used by the virtual host
operating system. Without encryption, sensitive user information could
be accessed on this disk, and vestigial information could remain after
the disk is unmounted.

The ephemeral disk encryption feature, can interface with a key
management service through a secure wrapper and support data isolation
by providing ephemeral disk encryption keys on a per-tenant basis.
Back-end key storage is recommended for enhanced security (for example,
an HSM or KMIP server can be used as a barbican back-end secret store).

For more details, see the `Ephemeral disk encryption documentation
<https://docs.openstack.org/security-guide/tenant-data/data-encryption.html#ephemeral-disk-encryption>`_.

Sahara
------

Sahara generates and stores several passwords during the course of
operation. To harden sahara’s usage of passwords it can be instructed
to use an external key manager for storage and retrieval of these
secrets. To enable this feature, there must first be an OpenStack Key
Manager service deployed within the stack.

With a Key Manager service deployed on the stack, sahara must be
configured to enable the external storage of secrets. Sahara uses the
Castellan library to interface with the OpenStack Key Manager service.
This library provides configurable access to a key manager.

For more information, see the `Sahara advanced configuration guide <https://docs.openstack.org/developer/sahara/userdoc/advanced.configuration.guide.html#external-key-manager-usage>`_.

Magnum
------

To provide access to Docker Swarm or Kubernetes using the native clients
(``docker`` or ``kubectl`` respectively) magnum uses TLS certificates. To store
the certificates, it is recommended to use Barbican , or the Magnum
Database (``x590keypair``).

A local directory can also be used (``local``), but is considered insecure and
not suitable for a production enviroment.

For more details on setting up a certificate manager for Magnum, see the `Container Infrastructure Management service <https://docs.openstack.org/project-install-guide/container-infrastructure-management/newton/install.html>`_ documentation.

Octavia/LBaaS
-------------

The LBaaS (Load-Balancer-as-a-Service) feature of Neutron and the
Octavia project need certificates and their private keys to provide
load balancing for TLS connections. Barbican can be used to store this
sensitive information.

For more details, see  `How to create a TLS Loadbalancer <https://wiki.openstack.org/wiki/Network/LBaaS/docs/how-to-create-tls-loadbalancer>`_.  and `Deploy a TLS-terminated HTTPS load balancer <https://docs.openstack.org/developer/octavia/guides/basic-cookbook.html#deploy-a-tls-terminated-https-load-balancer>`_.

Swift
-----

Symmetric keys can be used to encrypt Swift containers to mitigate the risk of
users data being read if an unauthorised party were to gain physical access to
a disk.

For more details, see  `Object Encryption <https://docs.openstack.org/swift/pike/overview_encryption.html>`_ within the official swift
documentation.

Passwords in Config Files
-------------------------

The configuration files for the OpenStack services contain a number of
passwords which are in plain text. These include, for instance, the
passwords used by service users to authenticate to keystone to validate
keystone tokens.

There is no current solution to obfuscate these passwords.  It is recommended
that these files be appropriately secured by file permissions.

There is currently an effort underway to store these secrets in a Castellan
back-end and then have oslo.config use Castellan to retrieve these secrets.
