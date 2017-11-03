=================================
System documentation requirements
=================================

System roles and types
~~~~~~~~~~~~~~~~~~~~~~

The two broadly defined types of nodes that generally make up an OpenStack
installation are:

Infrastructure nodes
   Run the cloud related services such as the OpenStack
   Identity service, the message queuing service, storage, networking, and
   other services required to support the operation of the cloud.

Compute, storage, or other resource nodes
   Provide storage capacity or virtual machines for your cloud.

System inventory
~~~~~~~~~~~~~~~~

Documentation should provide a general description of the OpenStack environment
and cover all systems used (for example, production, development, or test).
Documenting system components, networks, services, and software often provides
the bird's-eye view needed to thoroughly cover and consider security concerns,
attack vectors, and possible security domain bridging points. A system
inventory may need to capture ephemeral resources such as virtual machines or
virtual disk volumes that would otherwise be persistent resources in a
traditional IT system.

Hardware inventory
------------------

Clouds without stringent compliance requirements for written documentation
might benefit from having a Configuration Management Database (CMDB). CMDBs
are normally used for hardware asset tracking and overall life-cycle
management. By leveraging a CMDB, an organization can quickly identify
cloud infrastructure hardware such as compute nodes, storage nodes, or
network devices. A CMDB can assist in identifying assets that exist on
the network which may have vulnerabilities due to inadequate
maintenance, inadequate protection, or being displaced and forgotten. An
OpenStack provisioning system can provide some basic CMDB functions if
the underlying hardware supports the necessary auto-discovery features.

Software inventory
------------------

As with hardware, all software components within the OpenStack deployment
should be documented. Examples include:

* System databases, such as MySQL or mongoDB
* OpenStack software components, such as Identity or Compute
* Supporting components, such as load-balancers, reverse proxies, DNS, or DHCP
  services

An authoritative list of software components may be critical when assessing the
impact of a compromise or vulnerability in a library, application or class of
software.

Network topology
~~~~~~~~~~~~~~~~

A network topology should be provided with highlights specifically calling out
the data flows and bridging points between the security domains. Network
ingress and egress points should be identified along with any OpenStack logical
system boundaries. Multiple diagrams might be needed to provide complete visual
coverage of the system. A network topology document should include virtual
networks created on behalf of tenants by the system along with virtual machine
instances and gateways created by OpenStack.

Services, protocols, and ports
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Knowing information about organizational assets is typically a best practice.
An assets table can assist with validating security requirements and help to
maintain standard security components such as firewall configuration, service
port conflicts, security remediation areas, and compliance. Additionally, the
table can help to understand the relationship between OpenStack components. The
table might include:

* Services, protocols, and ports being utilized in the OpenStack deployment.
* An overview of all services running within the cloud infrastructure.

It is highly recommended that OpenStack deployments have information similar to
this on record. The table can be created from information derived from a CMDB
or can be constructed manually.

A table example is provided below:

.. list-table::
   :header-rows: 1
   :widths: 10 20 20 20 20 20

   * - Service
     - Protocols
     - Ports
     - Purpose
     - Used by
     - Security domains(s)

   * - beam.smp
     - AMQP
     - 5672/tcp
     - AMQP message service
     - RabbitMQ
     - MGMT

   * - tgtd
     - iSCSI
     - 3260/tcp
     - iSCSI initiator service
     - iSCSI
     - PRIVATE(data network)

   * - sshd
     - ssh
     - 22/tcp
     - Allows secure login to nodes and guest VMs
     - Various
     - MGMT, GUEST, and PUBLIC as configured

   * - mysqld
     - mysql
     - 3306/tcp
     - MySQL database service
     - Various
     - MGMT

   * - apache2
     - http
     - 443/tcp
     - Dashboard
     - Tenants
     - PUBLIC

   * - dnsmasq
     - dns
     - 53/tcp
     - DNS services
     - Guest VMs
     - GUEST
