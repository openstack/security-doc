.. _shared_fs_share_types_acl:

=========================
Share type access control
=========================
A share type is an administrator-defined "type of service", comprised of a
tenant visible description, and a list of non-tenant-visible key-value pairs -
extra specifications. The manila-scheduler uses extra specifications to make
scheduling decisions, and drivers control the share creation.

The administrators can create and delete share types, and manage the extra
specifications that give them meaning inside the Shared File Systems service.
Tenants can list the share types and can use them to create new shares. For
details of managing the share types, see `Shared File Systems API
<http://developer.openstack.org/api-ref-share-v2.html#share-type>`_ and
`Share types managing
<http://docs.openstack.org/admin-guide/shared_file_systems_share_types.html>`_
documentation.

The shares types can be created as *public* and *private*. This is the level of
visibility for the share type that defines whether other tenants can or cannot
see it in a share types list and use it to create a new share.

By default, the share types are created as public. While creating a share type,
use :option:`--is_public` parameter set to ``False`` to make your share type
private for other tenants not to see it in a list of share types and create
new share with it.

The *public* share types are available to every tenant in a cloud.

The Shared File Systems service allows the administrators to grant or deny
access to the *private* share types for some certain tenants. You also can get
information about access for a specified private share type.

.. tip::

    Since the share types due to their extra specifications help to filter or
    choose back ends before users create a share, using access to the share
    types you can limit clients that can choose definite back end.

As an example, being an administrator user in admin tenant, you can create a
private share type named ``my_type`` and see it in the list. In the console
examples the logging in and out is omitted, and environment variables are
provided to show the current logged in user.

.. code:: console

 $ env | grep OS_
 ...
 OS_USERNAME=admin
 OS_TENANT_NAME=admin
 ...
 $ manila type-list --all
 +----+--------+-----------+-----------+-----------------------------------+-----------------------+
 | ID | Name   | Visibility| is_default| required_extra_specs              | optional_extra_specs  |
 +----+--------+-----------+-----------+-----------------------------------+-----------------------+
 | 4..| my_type| private   | -         | driver_handles_share_servers:False| snapshot_support:True |
 | 5..| default| public    | YES       | driver_handles_share_servers:True | snapshot_support:True |
 +----+--------+-----------+-----------+-----------------------------------+-----------------------+

The demo user in demo tenant can list the types and the private share type
named ``my_type`` is not visible for him.

.. code:: console

 $ env | grep OS_
 ...
 OS_USERNAME=demo
 OS_TENANT_NAME=demo
 ...
 $ manila type-list --all
 +----+--------+-----------+-----------+----------------------------------+----------------------+
 | ID | Name   | Visibility| is_default| required_extra_specs             | optional_extra_specs |
 +----+--------+-----------+-----------+----------------------------------+----------------------+
 | 5..| default| public    | YES       | driver_handles_share_servers:True| snapshot_support:True|
 +----+--------+-----------+-----------+----------------------------------+----------------------+

The administrator can grant the access to the private share type for the demo
tenant with the tenant ID equal to df29a37db5ae48d19b349fe947fada46:

.. code:: console

 $ env | grep OS_
 ...
 OS_USERNAME=admin
 OS_TENANT_NAME=admin
 ...
 $ openstack project list
 +----------------------------------+--------------------+
 | ID                               | Name               |
 +----------------------------------+--------------------+
 | ...                              | ...                |
 | df29a37db5ae48d19b349fe947fada46 | demo               |
 +----------------------------------+--------------------+
 $ manila type-access-add my_type df29a37db5ae48d19b349fe947fada46

Thus now the users in demo tenant can see the private share type and use it in
the share creation:

.. code:: console

 $ env | grep OS_
 ...
 OS_USERNAME=demo
 OS_TENANT_NAME=demo
 ...
 $ manila type-list --all
 +----+--------+-----------+-----------+-----------------------------------+-----------------------+
 | ID | Name   | Visibility| is_default| required_extra_specs              | optional_extra_specs  |
 +----+--------+-----------+-----------+-----------------------------------+-----------------------+
 | 4..| my_type| private   | -         | driver_handles_share_servers:False| snapshot_support:True |
 | 5..| default| public    | YES       | driver_handles_share_servers:True | snapshot_support:True |
 +----+--------+-----------+-----------+-----------------------------------+-----------------------+

To deny access for a specified project, use
:command:`manila type-access-remove <share_type> <project_id>` command.

.. tip::

    A **real production use case** that shows the purpose of a share types and
    access to them is a situation when you have two back ends: cheap LVM as a
    public storage and expensive Ceph as a private storage. In this case you
    can grant access to the certain tenants and make the access with
    ``user/group`` authentication method.
