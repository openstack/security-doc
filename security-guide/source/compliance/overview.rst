===================
Compliance overview
===================

Security principles
~~~~~~~~~~~~~~~~~~~

Industry standard security principles provide a baseline for compliance
certifications and attestations. If these principles are considered and
referenced throughout an OpenStack deployment, certification activities
may be simplified.

Layered defenses
----------------

Identify where risks exist in a cloud architecture and apply controls
to mitigate the risks. In areas of significant concern, layered
defenses provide multiple complementary controls to manage risk down to
an acceptable level. For example, to ensure adequate isolation between
cloud tenants, we recommend hardening :term:`QEMU <Quick EMUlator (QEMU)>`,
using a hypervisor with SELinux support, enforcing mandatory access control
policies, and reducing the overall attack surface. The foundational principle
is to harden an area of concern with multiple layers of defense such that if
any one layer is compromised, other layers will exist to offer
protection and minimize exposure.

Fail securely
-------------

In the case of failure, systems should be configured to fail into a
closed secure state. For example, TLS certificate verification should
fail closed by severing the network connection if the CNAME does not
match the server's DNS name. Software often fails open in this
situation, allowing the connection to proceed without a CNAME match,
which is less secure and not recommended.

Least privilege
---------------

Only the minimum level of access for users and system services is
granted. This access is based upon role, responsibility and job
function. This security principle of least privilege is written into
several international government security policies, such as NIST 800-53
Section AC-6 within the United States.

Compartmentalize
----------------

Systems should be segregated in such a way that if one machine, or
system-level service, is compromised the security of the other systems
will remain intact. Practically, the enablement and proper usage of
SELinux helps accomplish this goal.

Promote privacy
----------------

The amount of information that can be gathered about a system and its
users should be minimized.

Logging capability
------------------

Appropriate logging is implemented to monitor for unauthorized use,
incident response and forensics. We highly recommend selected
audit subsystems be Common Criteria certified, which provides
non-attestable event records in most countries.

Common control frameworks
~~~~~~~~~~~~~~~~~~~~~~~~~

The following is a list of Control Frameworks that an organization can
use to build their security controls.

`Cloud Security Alliance (CSA) Common Control Matrix
(CCM) <https://cloudsecurityalliance.org/media/news/csa-releases-new-ccm-caiq-v3-0-1/>`_

The CSA CCM is specifically designed to provide fundamental security
principles to guide cloud vendors and to assist prospective cloud
customers in assessing the overall security risk of a cloud provider.
The CSA CCM provides a controls framework that are aligned across 16
security domains. The foundation of the Cloud Controls Matrix rests on
its customized relationship to other industry standards, regulations,
and controls frameworks such as: ISO 27001:2013, COBIT 5.0, PCI:DSS v3,
AICPA 2014 Trust Service Principles and Criteria and augments internal
control direction for service organization control reports attestations.

The CSA CCM strengthens existing information security control
environments by enabling the reduction of security threats and
vulnerabilities in the cloud, provides standardized security and
operational risk management, and seeks to normalize security
expectations, cloud taxonomy and terminology, and security measures
implemented in the cloud.

`ISO 27001/2:2013 <http://www.27000.org/iso-27001.htm>`_

The ISO 27001 Information Security standard and certification has been
used for many years to evaluate and distinguish an organizations
alignment with information Security best practices. The standard is
comprised of two parts: Mandatory Clauses that define the Information
Security Management System (ISMS) and Annex A which contains a list of
controls organized by domain.

The information security management system preserves the
confidentiality, integrity, and availability of information by applying
a risk management process and gives confidence to interested parties
that risks are adequately managed.

`Trusted Security
Principles <http://www.aicpa.org/interestareas/informationtechnology/resources/soc/trustservices/pages/trust%20services%20principles—an%20overview.aspx>`_

Trust Services are a set of professional attestation and advisory
services based on a core set of principles and criteria that address
the risks and opportunities of IT-enabled systems and privacy programs.
Commonly known as the SOC audits, the principles define what the
requirement is and it is the organizations responsibility to define the
control that meets the requirement.

Audit reference
~~~~~~~~~~~~~~~

OpenStack is innovative in many ways however the process used to audit
an OpenStack deployment is fairly common. Auditors will evaluate a
process by two criteria: Is the control designed effectively and if the
control is operating effectively. An understanding of how an auditor
evaluates if a control is designed and operating effectively will be
discussed in the section called :doc:`understanding-the-audit-process`.

The most common frameworks for auditing and evaluating a cloud
deployment include the previously mentioned ISO 27001/2 Information
Security standard, ISACA's Control Objectives for Information and
Related Technology (COBIT) framework, Committee of Sponsoring
Organizations of the Treadway Commission (COSO), and Information
Technology Infrastructure Library (ITIL). It is very common for audits
to include areas of focus from one or more of these frameworks.
Fortunately there is a lot of overlap between the frameworks, so an
organization that adopts one will be in a good position come audit
time.
