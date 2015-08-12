======================================
Securing OpenStack networking services
======================================

This section discusses OpenStack Networking configuration best practices
as they apply to tenant network security within your OpenStack
deployment.

Tenant network services workflow
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack Networking provides users self services of network resources
and configurations. It is important that cloud architects and operators
evaluate their design use cases in providing users the ability to
create, update, and destroy available network resources.

Networking resource policy engine
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A policy engine and its configuration file, :file:`policy.json`, within
OpenStack Networking provides a method to provide finer grained
authorization of users on tenant networking methods and objects. The
OpenStack Networking policy definitions affect network availability,
network security and overall OpenStack security. Cloud architects and
operators should carefully evaluate their policy towards user and tenant
access to administration of network resources. For a more detailed
explanation of OpenStack Networking policy definition, please refer to
the `Authentication and authorization
section <http://docs.openstack.org/admin-guide-cloud/content/section_networking_auth.html>`__
in the OpenStack Cloud Administrator Guide.

.. note::

    It is important to review the default networking resource policy, as
    this policy can be modified to suit your security posture.

If your deployment of OpenStack provides multiple external access points
into different security domains it is important that you limit the
tenant's ability to attach multiple vNICs to multiple external access
points—this would bridge these security domains and could lead to
unforeseen security compromise. It is possible mitigate this risk by
utilizing the host aggregates functionality provided by OpenStack
Compute or through splitting the tenant VMs into multiple tenant
projects with different virtual network configurations.

.. _networking-security-groups:

Security groups
~~~~~~~~~~~~~~~

The OpenStack Networking service provides security group functionality
using a mechanism that is more flexible and powerful than the security
group capabilities built into OpenStack Compute. Thus, :file:`nova.conf`
should always disable built-in security groups and proxy all security
group calls to the OpenStack Networking API when using OpenStack
Networking. Failure to do so results in conflicting security policies
being simultaneously applied by both services. To proxy security groups
to OpenStack Networking, use the following configuration values:

-  ``firewall_driver`` must be set to
   ``nova.virt.firewall.NoopFirewallDriver`` so that nova-compute does
   not perform iptables-based filtering itself.

-  ``security_group_api`` must be set to ``neutron`` so that all
   security group requests are proxied to the OpenStack Networking
   service.

A security group is a container for security group rules. Security
groups and their rules allow administrators and tenants the ability to
specify the type of traffic and direction (ingress/egress) that is
allowed to pass through a virtual interface port. When a virtual
interface port is created in OpenStack Networking it is associated with
a security group. If a security group is not specified, the port will be
associated with a 'default' security group. By default this group will
drop all ingress traffic and allow all egress. Rules can be added to
this group in order to change the behaviour.

When using the OpenStack Compute API to modify security groups, the
updated security group applies to all virtual interface ports on an
instance. This is due to the OpenStack Compute security group APIs being
instance-based rather than port-based, as found in OpenStack Networking.

Quotas
~~~~~~

Quotas provide the ability to limit the number of network resources
available to tenants. You can enforce default quotas for all tenants.
The :file:`/etc/neutron/neutron.conf` includes these options for quota:

.. code:: ini

    [QUOTAS]
    # resource name(s) that are supported in quota features
    quota_items = network,subnet,port

    # default number of resource allowed per tenant, minus for unlimited
    #default_quota = -1

    # number of networks allowed per tenant, and minus means unlimited
    quota_network = 10

    # number of subnets allowed per tenant, and minus means unlimited
    quota_subnet = 10

    # number of ports allowed per tenant, and minus means unlimited
    quota_port = 50

    # number of security groups allowed per tenant, and minus means unlimited
    quota_security_group = 10

    # number of security group rules allowed per tenant, and minus means unlimited
    quota_security_group_rule = 100

    # default driver to use for quota checks
    quota_driver = neutron.quota.ConfDriver

OpenStack Networking also supports per-tenant quotas limit through a
quota extension API. To enable per-tenant quotas, you must set the
``quota_driver`` option in :file:`neutron.conf`.

.. code:: ini

    quota_driver = neutron.db.quota_db.DbQuotaDriver
