======
Future
======

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
