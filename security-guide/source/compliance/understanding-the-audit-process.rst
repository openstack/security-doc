===============================
Understanding the audit process
===============================

Information system security compliance is reliant on the completion of
two foundational processes:

Implementation and operation of security controls
   Aligning the information system with in-scope standards and
   regulations involves internal tasks which must be conducted before
   a formal assessment.
   Auditors may be involved at this state to conduct gap analysis,
   provide guidance, and increase the likelihood of successful
   certification.

Independent verification and validation
   Demonstration to a neutral third-party that system security controls
   are implemented and operating effectively, in compliance with
   in-scope standards and regulations, is required before many
   information systems achieve certified status. Many certifications
   require periodic audits to ensure continued certification,
   considered part of an overarching continuous monitoring practice.

Determining audit scope
~~~~~~~~~~~~~~~~~~~~~~~

Determining audit scope, specifically what controls are needed and how
to design or modify an OpenStack deployment to satisfy them, should be
the initial planning step.

When scoping OpenStack deployments for compliance purposes,
prioritize controls around sensitive services, such as command and
control functions and the base virtualization technology. Compromises of
these facilities may impact an OpenStack environment in its entirety.

Scope reduction helps ensure OpenStack architects establish high quality
security controls which are tailored to a particular deployment, however
it is paramount to ensure these practices do not omit areas or features
from security hardening. A common example is applicable to PCI-DSS
guidelines, where payment related infrastructure may be scrutinized for
security issues, but supporting services are left ignored, and
vulnerable to attack.

When addressing compliance, you can increase efficiency and reduce work
effort by identifying common areas and criteria that apply across
multiple certifications. Much of the audit principles and guidelines
discussed in this book will assist in identifying these controls,
additionally a number of external entities provide comprehensive lists.
The following are some examples:

The `Cloud Security Alliance Cloud Controls
Matrix <https://cloudsecurityalliance.org/group/cloud-controls-matrix/>`_ (CCM)
assists both cloud providers and consumers in assessing the overall
security of a cloud provider. The CSA CMM provides a controls framework
that map to many industry-accepted standards and regulations including
the ISO 27001/2, ISACA, COBIT, PCI, NIST, Jericho Forum and NERC CIP.

The `SCAP Security
Guide <https://github.com/OpenSCAP/scap-security-guide/>`_ is another
useful reference. This is still an emerging source, but we anticipate
that this will grow into a tool with controls mappings that are more
focused on the US federal government certifications and recommendations.
For example, the SCAP Security Guide currently has some mappings for
security technical implementation guides (STIGs) and NIST-800-53.

These control mappings will help identify common control criteria across
certifications, and provide visibility to both auditors and auditees on
problem areas within control sets for particular compliance
certifications and attestations.

Phases of an audit
~~~~~~~~~~~~~~~~~~

An audit has four distinct phases, though most stakeholders and control owners
will only participate in one or two. The four phases are Planning, Fieldwork,
Reporting and Wrap-up. Each of these phases is discussed below.

The Planning phase is typically performed two weeks to six months before
Fieldwork begins. In this phase audit items such as the timeframe, timeline,
controls to be evaluated, and control owners are discussed and finalized.
Concerns about resource availability, impartiality, and costs are also
resolved.

The Fieldwork phase is the most visible portion of the audit. This is where
the auditors are onsite, interviewing the control owners, documenting the
controls that are in place, and identifying any issues. It is important to
note that the auditors will use a two part process for evaluating the controls
in place. The first part is evaluating the design effectiveness of the
control. This is where the auditor will evaluate whether the control is
capable of effectively preventing or detecting and correcting weaknesses and
deficiencies. A control must pass this test to be evaluated in the second
phase. This is because with a control that is designed ineffectually, there
is no point considering whether it is operating effectively. The second part
is operational effectiveness. Operational effectiveness testing will determine
how the control was applied, the consistency with which the control was
applied and by whom or by what means the control was applied. A control may
depend upon other controls (indirect controls) and, if they do, additional
evidence that demonstrates the operating effectiveness of those indirect
controls may be required for the auditor to determine the overall operating
effectiveness of the control.

The Reporting phase is where any issues that were identified during the
Fieldwork phase will be validated by management. For logistics
purposes, some activities such as issue validation may be performed during the
Fieldwork phase. Management will also need to provide remediation plans to
address the issues and ensure that they do not reoccur. A draft of the
overall report will be circulated for review to the stakeholders and
management. Agreed upon changes are incorporated and the updated draft is
sent to senior management for review and approval. Once senior management
approves the report, it is finalized and distributed to executive management.
Any issues are entered into the issue tracking or risk tracking mechanism the
organization uses.

The Wrap-up phase is where the audit is officially spun down. Management will
begin remediation activities at this point. Processes and notifications are
used to ensure that any audit related information is moved to a secure
repository.


Internal audit
~~~~~~~~~~~~~~

Once a cloud is deployed, it is time for an internal audit. This is the
time to compare the controls you identified above with the design,
features, and deployment strategies utilized in your cloud. The goal is
to understand how each control is handled and where gaps exist. Document
all of the findings for future reference.

When auditing an OpenStack cloud it is important to appreciate the
multi-tenant environment inherent in the OpenStack architecture. Some
critical areas for concern include data disposal, hypervisor security,
node hardening, and authentication mechanisms.

Prepare for external audit
~~~~~~~~~~~~~~~~~~~~~~~~~~

Once the internal audit results look good, it is time to prepare for an
external audit. There are several key actions to take at this stage,
these are outlined below:

-  Maintain good records from your internal audit. These will prove
   useful during the external audit so you can be prepared to answer
   questions about mapping the compliance controls to a particular
   deployment.

-  Deploy automated testing tools to ensure that the cloud remains
   compliant over time.

-  Select an auditor.

Selecting an auditor can be challenging. Ideally, you are looking for
someone with experience in cloud compliance audits. OpenStack experience
is another big plus. Often it is best to consult with people who have
been through this process for referrals. Cost can vary greatly depending
on the scope of the engagement and the audit firm considered.

External audit
~~~~~~~~~~~~~~

This is the formal audit process. Auditors will test security controls
in scope for a specific certification, and demand evidentiary
requirements to prove that these controls were also in place for the
audit window (for example SOC 2 audits generally evaluate security
controls over a 6-12 months period). Any control failures are logged,
and will be documented in the external auditors final report. Dependent
on the type of OpenStack deployment, these reports may be viewed by
customers, so it is important to avoid control failures. This is why
audit preparation is so important.

Compliance maintenance
~~~~~~~~~~~~~~~~~~~~~~

The process does not end with a single external audit. Most
certifications require continual compliance activities which means
repeating the audit process periodically. We recommend integrating
automated compliance verification tools into a cloud to ensure that it
is compliant at all times. This should be in done in addition to other
security monitoring tools. Remember that the goal is both security and
compliance. Failing on either of these fronts will significantly
complicate future audits.
