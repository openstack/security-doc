============
Case studies
============

Previously we discussed typical OpenStack management interfaces and
associated backplane issues. We will now approach these issues by
returning to the Alice and Bob case studies (See
:doc:`../introduction/introduction-to-case-studies`) where Alice is
deploying a government cloud and Bob is deploying a public cloud each
with different security requirements. In this section, we will look
into how both Alice and Bob will address:

-  Cloud administration

-  Self service

-  Data replication and recovery

-  SLA and security monitoring

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

Alice's cloud has very strict requirements around management and
interfaces. She builds an SVN repository and uploads the baseline
configuration files there for service teams to modify and deploy through
tool automation. User and group accounts for each service are created
with the principle of least privilege in mind. Service teams also have
their roles defined, and are given or denied access as well. For
example, the development team is not given production access, however an
escalation path is outlined through Alice's Security Operations Center
where privileges can be added and audited during issues. Additionally,
an update and patching policy is created, with tiered criticalities for
normal updates compared to security or other critical fixes that may be
more time sensitive.

For out-of-band management Alice has included a BMC/IPMI version
specification for the 'Request for Pricing' (RFP) which she submits to
approved hardware vendors for quotes and system specifications. This
includes ensuring communication with the out-of-band management
interface can be encrypted with TLS for both textual and GUI access. She
ensures that a network intrusion detection system (NIDS) will be
monitoring the management security domain that the IPMI traffic will be
using. Depending on usage, which may vary throughout the year, Alice may
set the NIDS to do passive anomoly detection so that packets are not
missed by the NIDS while it is processing.

Alice also creates 'golden images' of various systems that will be used
to quickly spin up a new instance. These golden images already have the
service accounts, configuration details, logging, and other policies
set. One is built for each service type that may be needed, such as a
golden image for API endpoints, hypervisors, network devices, message
queue instances, and any other devices that are commonly used or may
need to be recreated quickly. She then ensures a process exists for
updating golden images on a regular schedule as well as reporting
package versions for each image, as well as what will be used by the
Ansible configuration management tool, and exporting that data into the
CMDB automatically.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

As a public cloud provider, Bob is concerned with both the continuous
availability of management interfaces and the security of transactions
to the management interfaces. To that end Bob implements multiple
redundant OpenStack API endpoints for the services his cloud will run.
Additionally on the public network Bob uses TLS to encrypt all
transactions between his customers and his cloud interfaces. To isolate
his cloud operations Bob has physically isolated his management,
instance migration, and storage networks.

To ease scaling and reduce management overhead Bob implements a
configuration management system. For customer data assurances, Bob
offers a backup as a service product as requirements will vary between
customers. Finally, Bob does not provide a "baremetal" or the ability to
schedule an entire node, so to reduce management overhead and increase
operational efficiency Bob does not implement any node boot time
security.
