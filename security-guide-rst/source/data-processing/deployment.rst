==========
Deployment
==========

The Data processing service is deployed, like many other OpenStack
services, as an application running on a host connected to the stack.
As of the Kilo release, it has the ability to be deployed in a
distributed manner with several redundant controllers. Like other
services, it also requires a database to store information about its
resources. See :doc:`../databases`. It is important to note that the Data
processing service will need to manage several Identity service trusts,
communicate directly with the Orchestration and Networking services,
and potentially create users in a proxy domain. For these reasons the
controller will need access to the control plane and as such we
recommend installing it alongside other service controllers.

Data processing interacts directly with several openstack services:

* Compute
* Identity
* Networking
* Object Storage
* Orchestration
* Block Storage (optional)

We recommend documenting all the data flows and bridging points
between these services and the data processing controller. See
:doc:`../documentation`.

The Object Storage service is used by the Data processing service to store
job binaries and data sources. Users wishing to have access to the full
Data processing service functionality will need an object store in the
projects they are using.

The Networking service plays an important role in the provisioning of
clusters. Prior to provisioning, the user is expected to provide one
or more networks for the cluster instances. The action of associating
networks is similar to the process of assigning networks when
launching instances through the dashboard. These networks are used by
the controller for administrative access to the instances and
frameworks of its clusters.

Also of note is the Identity service. Users of the Data processing service
will need appropriate roles in their projects to allow the provisioning of
instances for their clusters. Installations that use the proxy domain
configuration require special consideration. See
:ref:`data-processing-proxy-domains`. Specifically, the Data processing
service will need the ability to create users within the proxy domain.

Controller network access to clusters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One of the primary tasks of the data processing controller is to
communicate with the instances it spawns. These instances are
provisioned and then configured depending on the framework being
used. The communication between the controller and the instances uses
secure shell (SSH) and HTTP protocols.

When provisioning clusters each instance will be given an IP address in
the networks provided by the user. The first network is often referred
to as the data processing management network and instances can use the
fixed IP address assigned by the Networking service for this network.
The controller can also be configured to use floating IP addresses for
the instances in addition to their fixed address. When communicating
with the instances the controller will prefer the floating address
if enabled.

For situations where the fixed and floating IP addresses do not
provide the functionality required the controller can provide access
through two alternate methods: custom network topologies and indirect
access. The custom network topologies feature allows the controller to
access the instances through a supplied shell command in the
configuration file. Indirect access is used to specify instances that
can be used as proxy gateways by the user during cluster provisioning.
These options are discussed with examples of usage in
:doc:`configuration-and-hardening`.
