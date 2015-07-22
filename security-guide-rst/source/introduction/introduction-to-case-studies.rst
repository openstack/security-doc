============================
Introduction to case studies
============================

This guide refers to two running case studies, which are introduced here
and referred to at the end of each chapter.

Case study: Alice, the private cloud builder
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Alice is a technical manager overseeing a new OpenStack deployment for
the US government in support of Healthcare.gov. The load on the cloud is
expected to be variable, with moderate usage increasing to heavy usage
during annual enrollment periods. She is aware that her private cloud
will need to be certified against FISMA through the FedRAMP
accreditation process required for all federal agencies, departments,
and contractors as well as being under HIPAA purview. These compliance
frameworks will place the burden of effort around logging, reporting,
and policy. While technical controls will require Alice to use Public
Key Infrastructure to encrypt wire-level communication, and SELinux for
Mandatory Access Controls, Alice will invest in tool development to
automate the reporting. Additionally, comprehensive documentation is
expected covering application and network architecture, controls, and
other details. The FedRAMP classification of Alice's system is High per
FIPS-199. Alice will leverage existing authentication/authorization
infrastructure in the form of Microsoft Active Directory, and an
existing enterprise SEIM deployment that she will use to build new views
and correlation rules to better monitor the state of her cloud.

Case study: Bob, the public cloud provider
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Bob is a lead architect for a company that deploys a large greenfield
public cloud. This cloud provides IaaS for the masses and enables any
consumer with a valid credit card access to utility computing and
storage, but the primary focus is enterprise customers. Data privacy
concerns are a big priority for Bob as they are seen as a major barrier
to large-scale adoption of the cloud by organizations.
