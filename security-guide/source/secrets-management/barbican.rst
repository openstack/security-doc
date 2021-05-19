========
Barbican
========

Overview
--------

Barbican is a REST API designed for the secure storage, provisioning and
management of secrets such as passwords, encryption keys and X.509
certificates. It is aimed at being useful for all environments,
including large ephemeral clouds.

Barbican is integrated with several OpenStack features, either directly
or as a back end of `Castellan <https://wiki.openstack.org/wiki/Castellan>`_.

Barbican is often used as a key management system to enable use cases such as
Image signature verification, Volume encryption. These use cases are outlined
in the :doc:`secrets-management-use-cases`

Barbican Role Based Access Control
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

pending

Secret store back ends
~~~~~~~~~~~~~~~~~~~~~~

The Key Manager service has a plugin architecture that allows the
deployer to store secrets in one or more secret stores. Secret stores
can be software-based, such as a software token, or hardware devices
such as a hardware security module (HSM). This section describes the
plugins that are currently available and discusses the security posture
of each one. Plugins are enabled and configured with settings in the
``/etc/barbican/barbican.conf`` configuration file.

There are two types of plugins: crypto plugins and secret store plugins.

Crypto plugins
--------------

Crypto plugins store secrets as encrypted blobs within the Barbican
database. The plugin is invoked to encrypt the secret on secret
storage, and decrypt the secret on secret retrieval. There are two
flavors of storage plugins currently available: the Simple Crypto plugin
and the PKCS#11 crypto plugin.

Simple crypto plugin
--------------------

The simple crypto plugin is configured by default in ``barbican.conf``.
This plugin uses single symmetric key (KEK - or 'Key Encryption Key')
which is stored in plain text in the ``barbican.conf`` file to encrypt
and decrypt all secrets. This plugin is considered a less secure option
and is only suitable for development and testing as the master key is stored
within a config file in plain text, and is therefore not recommended
for use in production deployments.

PKCS#11 crypto plugin
---------------------

The PKCS#11 crypto plugin can be used to interface with a Hardware
Security Module (HSM) using the PKCS#11 protocol. Secrets are encrypted
(and decrypted on retrieval) by a project specific Key Encryption Key
(KEK). The KEK is protected (encrypted) with a Master KEK (MKEK). The MKEK
resides in the HSM along with a HMAC. Since the different KEK is used for
each project, and since the KEKs are stored inside a database in an encrypted
form (instead of a plaintext in the configuration file) the PKCS#11 plugin
is much more secure than the simple crypto plugin. It is the most popular
back end amongst Barbican deployments.

Secret store plugins
--------------------

Secret store plugins interface with secure storage systems to store the
secrets within those systems. There are three types of secret store
plugins: the KMIP plugin, the Dogtag plugin, and the Vault plugin.

KMIP plugin
-----------

The `Key Management Interoperability Protocol (KMIP) <https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=kmip>`_
secret store plugin is used to communicate with a KMIP-enabled device, such as
a Hardware Security Module (HSM). The secret is securely stored in the
KMIP-enabled device directly, rather than in the Barbican database.
The Barbican database maintains a reference to the secret's location for
later retrieval. The plugin can be configured to authenticate to the
KMIP-enabled device using either a username and password, or using a client
certificate. This information is stored in the Barbican configuration file.

Dogtag plugin
-------------

The Dogtag secret store plugin is used to communicate with `Dogtag <http://pki.fedoraproject.org/wiki/PKI_Main_Page>`_.
Dogtag is the upstream project corresponding to the Red Hat Certificate
System, a Common Criteria/FIPS certified PKI solution that contains a
Certificate Manager (CA) and a Key Recovery Authority (KRA) which is use
to securely store secrets. The KRA stores secrets as encrypted blobs in
its internal database, with the master encryption keys being stored
either in a software-based NSS security database, or in a Hardware
Security Module (HSM). The software-based NSS database configuration
provides a secure option for deployments that do not wish to use a HSM.
The KRA is a component of FreeIPA, therefore it is possible to configure
the plugin with a FreeIPA server. More detailed instructions on how to
set up Barbican with FreeIPA are provided `in the following blog post <https://vakwetu.wordpress.com/2015/11/30/barbican-and-dogtagipa/>`_.

Vault plugin
------------

`Vault <https://www.vaultproject.io/>`_ is a secret storage developed by
Hashicorp for securely accessing secrets and other objects, such as API
keys, passwords, or certificates. Vault provides a unified interface to
any secret, while providing tight access control and recording a detailed
audit log. The enterprise version of Vault also allows to integrate with
HSM for auto-unseal, provide FIPS KeyStorage and entropy augmentation.
However, the downside of the Vault plugin is that it does not support
multitenancy, thus all secrets will be stored under the same
`Key/Value secret engine <https://www.vaultproject.io/docs/secrets/kv/kv-v2>`_.
mountpoint.

Threat analysis
~~~~~~~~~~~~~~~

The Barbican team worked with the OpenStack Security Project to perform a
security review of a best practise Barbican deployment. The objective of
the security review is to identify weaknesses and defects in the design
and architecture of services, and propose controls or fixes to resolve
these issues.

The Barbican threat analysis identified eight security findings and two
recommendations to improve the security of a barbican deployment. These
results can be reviewed in the `security analysis repo <https://github.com/openstack/security-analysis/tree/master/doc/source/artifacts/barbican/newton>`_., along with the
Barbican architecture diagram and architecture description page.
