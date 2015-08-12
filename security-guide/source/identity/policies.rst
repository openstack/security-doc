========
Policies
========

Each OpenStack service has a policy file in JSON format, called
:file:`policy.json`. The policy file specifies rules, and the rule that
governs each resource. A resource could be API access, the ability to
attach to a volume, or to fire up instances.

The policies can be updated by the cloud administrator to further
control access to the various resources. The middleware could also be
further customized. Note that your users must be assigned to
groups/roles that you refer to in your policies.

Below is a snippet of the :file:`policy.json` file.

.. code:: json

   {
       "admin_required": "role:admin",
       "cloud_admin": "rule:admin_required and domain_id:admin_domain_id",
       "service_role": "role:service",
       "service_or_admin": "rule:admin_required or rule:service_role",
       "owner" : "user_id:%(user_id)s or user_id:%(target.token.user_id)s",
       "admin_or_owner": "(rule:admin_required and domain_id:%(target.token.user.domain.id)s) or rule:owner",
       "admin_or_cloud_admin": "rule:admin_required or rule:cloud_admin",
       "admin_and_matching_domain_id": "rule:admin_required and domain_id:%(domain_id)s",
       "service_admin_or_owner": "rule:service_or_admin or rule:owner",

       "default": "rule:admin_required",

       "identity:get_service": "rule:admin_or_cloud_admin",
       "identity:list_services": "rule:admin_or_cloud_admin",
       "identity:create_service": "rule:cloud_admin",
       "identity:update_service": "rule:cloud_admin",
       "identity:delete_service": "rule:cloud_admin",

       "identity:get_endpoint": "rule:admin_or_cloud_admin",
       "identity:list_endpoints": "rule:admin_or_cloud_admin",
       "identity:create_endpoint": "rule:cloud_admin",
       "identity:update_endpoint": "rule:cloud_admin",
       "identity:delete_endpoint": "rule:cloud_admin",

       "identity:get_domain": "rule:cloud_admin",
       "identity:list_domains": "rule:cloud_admin",
       "identity:create_domain": "rule:cloud_admin",
       "identity:update_domain": "rule:cloud_admin",
       "identity:delete_domain": "rule:cloud_admin",

       ...
   }

Note the **cloud_admin** rule specifies that the user must be an admin
on a certain domain. It essentially says only the cloud admin may
create/delete/update services and their endpoints. Certain other
operations such as listing/retrieving details of services and endpoints
are accessible only to admin users.
