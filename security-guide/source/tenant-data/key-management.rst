==============
Key management
==============


To address the often mentioned concern of tenant data privacy and limiting
cloud provider liability, there is greater interest within the OpenStack
community to make data encryption more ubiquitous. It is relatively easy for an
end-user to encrypt their data prior to saving it to the cloud, and this is a
viable path for tenant objects such as media files, database archives among
others. In some instances, client-side encryption is utilized to encrypt data
held by the virtualization technologies which requires client interaction, such
as presenting keys, to decrypt data for future use. To seamlessly secure the
data and have it accessible without burdening the client with having to manage
their keys and interactively provide them calls for a key management service
within OpenStack. Providing encryption and key management services as part of
OpenStack eases data-at-rest security adoption and addresses customer concerns
about privacy or misuse of data, while also limiting cloud provider liability.
This can help reduce a provider's liability when handling tenant data during an
incident investigation in multi-tenant public clouds.

The volume encryption and ephemeral disk encryption features rely on a key
management service (for example, barbican) for the creation and secure storage
of keys. The key manager is pluggable to facilitate deployments that need a
third-party Hardware Security Module (HSM) or the use of the Key Management
Interchange Protocol (KMIP), which is supported by an open-source project
called PyKMIP.

Bibliography:
~~~~~~~~~~~~~

-  OpenStack.org, Welcome to barbican's Developer Documentation!. 2014.
   `Barbican developer
   documentation <https://docs.openstack.org/barbican/latest/>`__

-  oasis-open.org, OASIS Key Management Interoperability Protocol
   (KMIP). 2014.
   `KMIP <https://www.oasis-open.org/committees/tc_home.php?wg_abbrev=kmip>`__

-  `PyKMIP library <https://github.com/OpenKMIP/PyKMIP>`__

-  Secrets Management :ref:`secrets-management`
