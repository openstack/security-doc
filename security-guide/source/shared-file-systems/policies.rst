.. _shared_fs_policies:

========
Policies
========
Shared File Systems service has its own role-based access policies. They
determine which user can access which objects in which way, and are defined in
the service's ``policy.json`` file.

.. tip::
    The configuration file ``policy.json`` may be used from different places.
    The path ``/etc/manila/policy.json`` is one of expected paths by default.

Whenever an API call to the Shared File Systems service is made, the policy
engine uses the appropriate policy definitions to determine if the call can be
accepted.

The policy rule determines under which circumstances the API call is permitted.
The ``/etc/manila/policy.json`` file has rules where action is always
permitted, when the rule is an empty string: ``""``; the rules based on the
user role or rules; rules with boolean expressions. Below is a snippet of the
``policy.json`` file for the Shared File Systems service. From one
OpenStack release to another it can be changed.

.. code-block:: javascript

 {
     "context_is_admin": "role:admin",
     "admin_or_owner": "is_admin:True or project_id:%(project_id)s",
     "default": "rule:admin_or_owner",

     "admin_api": "is_admin:True",

     "share:create": "",
     "share:delete": "rule:default",
     "share:get": "rule:default",
     "share:get_all": "rule:default",
     "share:list_by_share_server_id": "rule:admin_api",
     "share:update": "rule:default",
     "share:snapshot_update": "rule:default",
     "share:create_snapshot": "rule:default",
     "share:delete_snapshot": "rule:default",
     "share:get_snapshot": "rule:default",
     "share:get_all_snapshots": "rule:default",
     "share:access_get": "rule:default",
     "share:access_get_all": "rule:default",
     "share:allow_access": "rule:default",
     "share:deny_access": "rule:default",
     "share:extend": "rule:default",
     "share:shrink": "rule:default",
     "share:get_share_metadata": "rule:default",
     "share:delete_share_metadata": "rule:default",
     "share:update_share_metadata": "rule:default",
     "share:migrate": "rule:admin_api",

     "share_type:index": "rule:default",
     "share_type:show": "rule:default",
     "share_type:default": "rule:default",

     "share_instance:index": "rule:admin_api",
     "share_instance:show": "rule:admin_api",

     "share_extension:quotas:show": "",
     "share_extension:quotas:update": "rule:admin_api",
     "share_extension:quotas:delete": "rule:admin_api",
     "share_extension:quota_classes": "",

     ...
 }

Note that your users must be assigned to groups and roles that you refer to in
your policies.

.. note::
    Any changes to ``/etc/manila/policy.json`` are effective immediately,
    which allows new policies to be implemented while the Shared File Systems
    service is running. Modifying the policy can have unexpected side effects
    and is not encouraged. For details, see `The policy.json file <http://docs.
    openstack.org/trunk/config-reference/content/policy-json-file.html>`_.
