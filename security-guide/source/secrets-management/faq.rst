==========================
Frequently Asked Questions
==========================

1. What is the recommended way to securely store secrets in OpenStack?

The recommended way to securely store and manage secrets in OpenStack
is to use Barbican.

2. Why should I use Barbican?

Barbican is an OpenStack service that is multi-tenant aware and that
uses Keystone tokens for authentication. This means that access to secrets is
controlled via OpenStack policies for tenants and RBAC roles.

Barbican has multiple pluggable back-ends which can communicate with
software and hardware based security modules using PKCS#11 or KMIP.

3. What if I don't want to use Barbican?

In an Openstack context, there are two types of secrets that need to
be managed - those that require a keystone token for access, and those that do
not.

An example of those secrets that require keystone authentication are
passwords and keys owned by specific projects. These include, for instance,
encryption keys for a project's encrypted cinder volumes or signing keys for a
project's glance images.

Examples of secrets that does not require a keystone token to access
are passwords for service users in service configuration files, or
encryption keys that do not belong to any particular project.

Secrets that require a keystone token should be stored using Barbican.

Secrets that do not require keystone authentication can be stored in any secret
store that implements the simple key storage API that is exposed through
Castellan. This also includes Barbican.

4. How can I use Vault, Keywhiz, Custodia etc ...?

The key manager of your choice can be used with Openstack if Castellan
plugin has been written for that key manager. Once that plugin
has been written, it is relatively trivial to use the plugin either directly or
behind Barbican.

Currently, Vault and Custodia plugins are being developed for the Queens cycle.
