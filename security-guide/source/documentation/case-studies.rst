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
domains, such as the API endpoints crossing the Public and Management domains,
the Identity data being served from a Federated entity crossing from a system
she does not manage to her Management domain, the Database service crossing
both Data and Guest domains, and hypervisor crossing Management, Guest, and
Public domains. She will then be able to dictate additional controls that
ensure and reinforce the trust level of each domain. For example, the
application will be exposed to the Internet, and therefore data coming through
that will initially be untrusted before it is moved through to the data domain
and into the database.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

In this case, Bob will take the same steps as Alice.
