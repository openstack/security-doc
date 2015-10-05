============
Case studies
============

Earlier in the :doc:`../introduction/introduction-to-case-studies`
we introduced the Alice and Bob case studies where Alice is deploying a
government cloud and Bob is deploying a public cloud each with different
security requirements. Here we discuss how Alice and Bob would address their
system documentation requirements. The documentation suggested above includes
hardware and software records, network diagrams, and system configuration
details.

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

As Alice needs detailed documentation to satisfy FISMA and FedRAMP
requirements, she implements Microsoft's Systems Center due to its established
auditing capabilities to support FedRAMP artifact creation, including capturing
hardware, firmware, and software details. Architecture docs are created that
clearly define the components, services, and data flows, with supporting
materials listing the details of those services including processes, protocols,
and ports used. These documents are then stored on a secured file share,
allowing authenticated access for service and architecture teams to reference.

Additionally, the security domains are clearly highlighted on each document,
and asset groups are categorized per the NIST Risk Management Framework.
Specifically, Alice will call out the fact that several services cross security
domains. The API endpoints cross the public and management domains,
the Identity data served from a federated entity crosses an external system
to her management domain, the database service crosses
data and guest domains, and the hypervisor crosses management, guest, and
public domains. Alice will then be able to dictate additional controls that
ensure and reinforce the trust level of each domain. For example, the
application will be exposed to the Internet, and therefore data coming through
that will initially be untrusted before it is moved through to the data domain
and into the database.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

Bob will also need detailed documentation to satisfy PCI compliance.
Looking forward, he realizes that many controls are duplicated across
compliance requirements, but may be under different categories. He
assigns a compliance manager who maps the PCI certification process and
necessary controls to similar certifications such as FedRAMP and HIPAA
so that there is a documented assessment of other audit frameworks, as
well as what artifacts can be duplicated, if an additional certification
needs to be obtained. Architecture documentation similar to Alice's are
created and secured.

With documentation created, security domains called out, and it all
stored where the service teams also have authenticated access, Bob looks
at system management. He outlines a :term:`configuration management
database (CMDB)<CMDB>` that will work with the PXE imaging system so
that whenever a device calls in for an image, the MAC address will be
used as the unique identifier in the CMDB entry. A script will report
back on the hardware and software configuration of the system so that
the CMDB will be populated on each system creation. He configures this
script to report to the CMDB once a week so that the information is
consistently refreshed, and schedules a manual audit of the information
on an annual basis to ensure the script is pulling information
accurately.
