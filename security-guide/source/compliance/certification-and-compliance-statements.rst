=======================================
Certification and compliance statements
=======================================

Compliance and security are not exclusive, and must be addressed
together. OpenStack deployments are unlikely to satisfy compliance
requirements without security hardening. The listing below provides an
OpenStack architect foundational knowledge and guidance to achieve
compliance against commercial and government certifications and
standards.

Commercial standards
~~~~~~~~~~~~~~~~~~~~
For commercial deployments of OpenStack, it is recommended that SOC 1/2
combined with ISO 2700 1/2 be considered as a starting point for
OpenStack certification activities. The required security activities
mandated by these certifications facilitate a foundation of security
best practices and common control criteria that can assist in achieving
more stringent compliance activities, including government attestations
and certifications.

After completing these initial certifications, the remaining
certifications are more deployment specific. For example, clouds
processing credit card transactions will need PCI-DSS, clouds storing
health care information require HIPAA, and clouds within the federal
government may require FedRAMP/FISMA, and ITAR, certifications.

SOC 1 (SSAE 16) / ISAE 3402
---------------------------
Service Organization Controls (SOC) criteria are defined by the
`American Institute of Certified Public
Accountants <http://www.aicpa.org/>`__ (AICPA). SOC controls assess
relevant financial statements and assertions of a :term:`service provider`,
such as compliance with the Sarbanes-Oxley Act. SOC 1 is a replacement for
Statement on Auditing Standards No. 70 (SAS 70) Type II report. These
controls commonly include physical data centers in scope.

There are two types of SOC 1 reports:

-  Type 1 - report on the fairness of the presentation of management's
   description of the service organization's system and the suitability
   of the design of the controls to achieve the related control
   objectives included in the description as of a specified date.

-  Type 2 - report on the fairness of the presentation of management's
   description of the service organization's system and the suitability
   of the design and operating effectiveness of the controls to achieve
   the related control objectives included in the description throughout
   a specified period

For more details see the `AICPA Report on Controls at a Service
Organization Relevant to User Entities' Internal Control over Financial
Reporting <http://www.aicpa.org/InterestAreas/FRC/AssuranceAdvisoryServices/Pages/AICPASOC1Report.aspx>`__.

SOC 2
-----
Service Organization Controls (SOC) 2 is a self attestation of controls
that affect the security, availability, and processing integrity of the
systems a service organization uses to process users' data and the
confidentiality and privacy of information processed by these system.
Examples of users are those responsible for governance of the service
organization; customers of the service organization; regulators;
business partners; suppliers and others who have an understanding of the
service organization and its controls.

There are two types of SOC 2 reports:

-  Type 1 - report on the fairness of the presentation of management's
   description of the service organization's system and the suitability
   of the design of the controls to achieve the related control
   objectives included in the description as of a specified date.

-  Type 2 - report on the fairness of the presentation of management's
   description of the service organization's system and the suitability
   of the design and operating effectiveness of the controls to achieve
   the related control objectives included in the description throughout
   a specified period.

For more details see the `AICPA Report on Controls at a Service
Organization Relevant to Security, Availability, Processing Integrity,
Confidentiality or
Privacy <http://www.aicpa.org/InterestAreas/FRC/AssuranceAdvisoryServices/Pages/AICPASOC2Report.aspx>`__.

SOC 3
-----
Service Organization Controls (SOC) 3 is a trust services report for
service organizations. These reports are designed to meet the needs of
users who want assurance on the controls at a service organization
related to security, availability, processing integrity,
confidentiality, or privacy but do not have the need for or the
knowledge necessary to make effective use of a SOC 2 Report. These
reports are prepared using the AICPA/Canadian Institute of Chartered
Accountants (CICA) Trust Services Principles, Criteria, and
Illustrations for Security, Availability, Processing Integrity,
Confidentiality, and Privacy. Because they are general use reports, SOC
3 Reports can be freely distributed or posted on a website as a seal.

For more details see the `AICPA Trust Services Report for Service
Organizations <http://www.aicpa.org/InterestAreas/FRC/AssuranceAdvisoryServices/Pages/AICPASOC3Report.aspx>`__.

ISO 27001/2
-----------
The ISO/IEC 27001/2 standards replace BS7799-2, and are specifications
for an Information Security Management System (ISMS). An ISMS is a
comprehensive set of policies and processes that an organization creates
and maintains to manage risk to information assets. These risks are
based upon the confidentiality, integrity, and availability (CIA) of
user information. The CIA security triad has been used as a foundation
for much of the chapters in this book.

For more details see `ISO 27001 <http://www.27000.org/iso-27001.htm>`__.

HIPAA / HITECH
--------------
The Health Insurance Portability and Accountability Act (HIPAA) is a
United States congressional act that governs the collection, storage,
use and destruction of patient health records. The act states that
Protected Health Information (PHI) must be rendered "unusable,
unreadable, or indecipherable" to unauthorized persons and that
encryption for data 'at-rest' and 'inflight' should be addressed.

HIPAA is not a certification, rather a guide for protecting healthcare
data. Similar to the PCI-DSS, the most important issues with both PCI
and HIPPA is that a breach of credit card information, and health data,
does not occur. In the instance of a breach the cloud provider will be
scrutinized for compliance with PCI and HIPPA controls. If proven
compliant, the provider can be expected to immediately implement
remedial controls, breach notification responsibilities, and significant
expenditure on additional compliance activities. If not compliant, the
cloud provider can expect on-site audit teams, fines, potential loss of
merchant ID (PCI), and massive reputation impact.

Users or organizations that possess PHI must support HIPAA requirements
and are HIPAA covered entities. If an entity intends to use a service,
or in this case, an OpenStack cloud that might use, store or have access
to that PHI, then a Business Associate Agreement must be signed. The BAA
is a contract between the HIPAA covered entity and the OpenStack service
provider that requires the provider to handle that PHI in accordance
with HIPAA requirements. If the service provider does not handle the
PHI, such as with security controls and hardening, then they are subject
to HIPAA fines and penalties.

OpenStack architects interpret and respond to HIPAA statements, with
data encryption remaining a core practice. Currently this would require
any protected health information contained within an OpenStack
deployment to be encrypted with industry standard encryption algorithms.
Potential future OpenStack projects such as object encryption will
facilitate HIPAA guidelines for compliance with the act.

For more details see the `Health Insurance Portability And
Accountability
Act <https://www.cms.gov/Regulations-and-Guidance/HIPAA-Administrative-Simplification/HIPAAGenInfo/downloads/HIPAALaw.pdf>`__.

PCI-DSS
-------
The Payment Card Industry Data Security Standard (PCI DSS) is defined by
the Payment Card Industry Standards Council, and created to increase
controls around card holder data to reduce credit card fraud. Annual
compliance validation is assessed by an external Qualified Security
Assessor (QSA) who creates a Report on Compliance (ROC), or by a
Self-Assessment Questionnaire (SAQ) dependent on volume of card-holder
transactions.

OpenStack deployments which stores, processes, or transmits payment card
details are in scope for the PCI-DSS. All OpenStack components that are
not properly segmented from systems or networks that handle payment data
fall under the guidelines of the PCI-DSS. Segmentation in the context of
PCI-DSS does not support multi-tenancy, but rather physical separation
(host/network).

For more details see `PCI security
standards <https://www.pcisecuritystandards.org/security_standards/>`__.

Government standards
~~~~~~~~~~~~~~~~~~~~

FedRAMP
-------
"The `Federal Risk and Authorization Management
Program <http://www.fedramp.gov>`__ (FedRAMP) is a government-wide
program that provides a standardized approach to security assessment,
authorization, and continuous monitoring for cloud products and
services". NIST 800-53 is the basis for both FISMA and FedRAMP which
mandates security controls specifically selected to provide protection
in cloud environments. FedRAMP can be extremely intensive from
specificity around security controls, and the volume of documentation
required to meet government standards.

For more details see `FedRAMP <http://www.gsa.gov/portal/category/102371>`_.

ITAR
----
The International Traffic in Arms Regulations (ITAR) is a set of United
States government regulations that control the export and import of
defense-related articles and services on the United States Munitions
List (USML) and related technical data. ITAR is often approached by
cloud providers as an "operational alignment" rather than a formal
certification. This typically involves implementing a segregated cloud
environment following practices based on the NIST 800-53 framework, as
per FISMA requirements, complemented with additional controls
restricting access to "U.S. Persons" only and background screening.

For more details see
`The International Traffic in Arms Regulations (ITAR)
<https://www.pmddtc.state.gov/regulations_laws/itar.html>`_.

FISMA
-----
The Federal Information Security Management Act requires that government
agencies create a comprehensive plan to implement numerous government
security standards, and was enacted within the E-Government Act of 2002.
FISMA outlines a process, which utilizing multiple NIST publications,
prepares an information system to store and process government data.

This process is broken apart into three primary categories:

System categorization:
 The information system will receive a security category as defined in
 Federal Information Processing Standards Publication 199 (FIPS 199).
 These categories reflect the potential impact of system compromise.

Control selection:
 Based upon system security category as defined in FIPS 199, an
 organization utilizes FIPS 200 to identify specific security control
 requirements for the information system. For example, if a system is
 categorized as "moderate" a requirement may be introduced to mandate
 "secure passwords".

Control tailoring:
 Once system security controls are identified, an OpenStack architect
 will utilize NIST 800-53 to extract tailored control selection. For
 example, specification of what constitutes a "secure password".
