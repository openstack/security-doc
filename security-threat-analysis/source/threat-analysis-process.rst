=======================
Threat Analysis Process
=======================

This page documents the process for a Threat Analysis review, which consists of
the following phases:

- Preparing artifacts for review
- Verifying readiness for a threat analysis review
- Running the threat analysis review
- Follow-up from the threat analysis review

Preparing artifacts for review
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Complete the architecture page. The architecture page describes the purpose
  of the service, and captures the information that is required for an
  effective threat analysis review. A template for the architecture page is
  provided at :ref:`architecture-page` and there is guidance on
  diagramming at :ref:`architecture-diagram-guidance`. If further help or
  advice is needed, please reach out to the Security Project via the
  openstack-dev@lists.openstack.org mailing list, tagging your email
  [security].
- The architecture page should describe a best practice deployment. If a
  reference architecture is available this may be a good example to use,
  otherwise the page should describe a best practice deployment, rather than
  the simplest possible deployment. Where reference architectures do not exist,
  it is possible that the architecture drawn for the threat analysis process
  can be used as a reference architecture.
- The following information is required in the architecture page for review:

  #. A brief description of the service, its purpose and intended usage.
  #. A list of components in the architecture, their purpose, any sensitive
     data they persist and protocols they expose.
  #. External dependencies and security assumptions made about them.
  #. An architecture block diagram.
  #. Either a sequence diagram or a data flow diagram, describing common
     operations of the service


Before the review
~~~~~~~~~~~~~~~~~

- Verify that the service’s architecture page contains all the sections
  listed in the Architecture Page Template :ref:`architecture-page`.
- The architecture page should include diagrams as specified in the
  Architecture Diagram guidance :ref:`architecture-diagram-guidance`.
- Send an email to the openstack-dev@lists.openstack.org mailing list with a
  [security] tag to announce the up-coming threat analysis review.
- Prepare a threat analysis review etherpad, using this template <link>.
- Print the architecture page as a PDF, to be checked in along with the review
  notes, as evidence of what was reviewed.

Running the threat analysis review
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Identify the "scribe" role, who will record the discussion and any
  findings in the etherpad.
- Ask the project architect to briefly describe the purpose of the service,
  typical uses cases, who will use it and how it will be deployed.
  Identify the data assets that might be at risk, eg peoples photos, cat
  videos, databases. Assets in flight and at rest.
- Briefly consider potential abuse cases, what might an attacker want to use
  this service for? Could an attacker use this service as a stepping stone to
  attack other services? Do not spend too long on this section, as abuse cases
  will come up as the architecture is discussed.
- Ask the project architect to summarize the architecture by stepping through
  the architecture block diagram. While reviewing the architecture, perform the
  following steps:

  #. For each interface between components, consider the confidentiality,
     integrity and availability requirements for that interface. Is
     sensitive data protected effectively to prevent information disclosure
     (loss of confidentiality) or tampering (loss of integrity)? Is there a
     requirement for availability which should be documented and added to
     reference deployments? In addition to considering the authenticity of
     the data in transit, consider how the authenticity of the sending and
     receiving nodes is assured.
  #. Consider the protocols used to pass data between interfaces. Is this an
     appropriate protocol, is it a current protocol, does it have documented
     vulnerabilities, is the implementation in use maintained? Is this protocol
     used as a security control to provide confidentiality, integrity or
     availability?
  #. Can this interface be used as an entry point to the system, can an
     attacker use it to attack a potentially vulnerable service? If so,
     consider what additional controls should be applied to limit the exposure.
  #. If an attacker was able to compromise a given component, what would that
     enable them to do? Could they stepping-stone through the OpenStack cloud?
  #. How is the service administered? Is this a secure path, with appropriate
     authentication and authorization controls?

- Once the reviewers are familiar with the service, re-consider abuse cases,
  are there any other cases which should be considered and mitigated?
- Step through typical use-case diagrams. Again consider if sensitive data is
  appropriately protected. Where an entry point is identified, consider how
  risks of malicious input data can be mitigated.
- If any potential vulnerabilities are identified, they should be discussed
  with the project team, if they agree that it is an issue then a note should
  be made in the findings section of the etherpad, with a short title and
  summary of the issue, including a note of who found it. If the project team
  disagree, then the note should be made under the further investigation
  section.


Follow-up from the threat analysis review
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Create a separate bug for each of the security findings listed in the TA
  Review notes.
- Update the Threat Analysis Review Etherpad each of the new launchpad bug
  numbers.
- Paste the contents of the Threat Analysis Review Etherpad into a text file in
  security-docs/security-ta/notes and push it to the security-review repo using
  gerit.
- Distribute the Threat Analysis Review Notes via email to all who were present
  at the threat analysis. If anyone discovers errors or omissions in the notes,
  then make corrections.
- On the threat analysis reviews wiki page create a new row in the reviews
  table, include a link to the master bug, the date of the review, the PTL and
  reviewers.
