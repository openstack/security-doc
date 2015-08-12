=======
Domains
=======

Domains are high-level containers for projects, users and groups. As
such, they can be used to centrally manage all keystone-based identity
components. With the introduction of account domains, server, storage
and other resources can now be logically grouped into multiple projects
(previously called tenants) which can themselves be grouped under a
master account-like container. In addition, multiple users can be
managed within an account domain and assigned roles that vary for each
project.

The Identity V3 API supports multiple domains. Users of different
domains may be represented in different authentication back ends and
even have different attributes that must be mapped to a single set of
roles and privileges, that are used in the policy definitions to access
the various service resources.

Where a rule may specify access to only admin users and users belonging
to the tenant, the mapping may be trivial. In other scenarios the cloud
administrator may need to approve the mapping routines per tenant.

Domain-specific authentication drivers allow the Identity service
to be configured for multiple domains using domain-specific configuration
files. Enabling the drivers and setting the domain-specific configuration file
location occur in the ``[identity]`` section of the :file:`keystone.conf` file:

.. code:: ini

   [identity]
   domain_specific_drivers_enabled = <replaceable>True</replaceable>
   domain_config_dir = /etc/keystone/domains</programlisting>

Any domains without a domain-specific configuration file
will use options in the primary :file:`keystone.conf` file.
