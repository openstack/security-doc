.. _policy-section:

========
Policies
========

Each OpenStack service defines the access policies for its resources in an
associated policy file. A resource, for example, could be API access, the
ability to attach to a volume, or to fire up instances. The policy rules are
specified in JSON format and the file is called ``policy.json``. The
syntax and format of this file is discussed in the `Configuration Reference
<https://docs.openstack.org/ocata/config-reference/policy-json-file.html>`__.

These policies can be modified or updated by the cloud administrator to
control the access to the various resources. Ensure that any changes to the
access control policies do not unintentionally weaken the security of any
resource. Also note that changes to the ``policy.json`` file become effective
immediately and do not require the service to be restarted.

The following example shows how the service can restrict access to create,
update and delete resources to only those users which have the role of
``cloud_admin``, which has been defined as being the conjunction of
``role = admin`` and ``domain_id = admin_domain_id``, while the get and list
resources are made available to users which have the role of ``cloud_admin``
or ``admin``.

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

       ...
   }

