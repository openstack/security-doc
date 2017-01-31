.. _shared_fs_policies:

========
Policies
========
Shared File Systems service has its own role-based access policies. They
determine which user can access which objects in which way, and are defined in
the service's ``policy.json`` file.

.. tip::

    The configuration file ``policy.json`` may be placed anywhere.
    The path ``/etc/manila/policy.json`` is expected by default.

Whenever an API call to the Shared File Systems service is made, the policy
engine uses the appropriate policy definitions to determine if the call can be
accepted.

A policy rule determines under which circumstances the API call is permitted.
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
       "share_extension:quotas:show": "",
       "share_extension:quotas:update": "rule:admin_api",
       "share_extension:quotas:delete": "rule:admin_api",
       "share_extension:quota_classes": "",
   }

Users must be assigned to groups and roles that you refer to in
your policies. This is done automatically by the service when user
management commands are used.

.. note::

    Any changes to ``/etc/manila/policy.json`` are effective immediately,
    which allows new policies to be implemented while the Shared File Systems
    service is running. Manual modification of the policy can have unexpected
    side effects and is not encouraged. For details, see
    `The policy.json file
    <https://docs.openstack.org/newton/config-reference/policy-json-file.html>`_.
