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

Below is a snippet of the Block Storage service :file:`policy.json`
file.

.. code:: json

   http://git.openstack.org/cgit/openstack/openstack-manuals/plain/doc/common/samples/policy.json

Note the **default** rule specifies that the user must be either an
admin or the owner of the volume. It essentially says only the owner of
a volume or the admin may create/delete/update volumes. Certain other
operations such as managing volume types are accessible only to admin
users.
