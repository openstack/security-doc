=====================
Compliance activities
=====================

There are a number of standard activities that will greatly assist with
the compliance process. This chapter outlines some of the most
common compliance activities. These are not specific to OpenStack,
however references are provided to relevant sections in this book as
useful context.

Information Security Management system (ISMS)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

An Information Security Management System (ISMS) is a comprehensive set
of policies and processes that an organization creates and maintains to
manage risk to information assets. The most common ISMS for cloud
deployments is `ISO/IEC 27001/2 <http://www.27000.org/iso-27001.htm>`_,
which creates a solid foundation of security controls and practices for
achieving more stringent compliance certifications. This standard was
updated in 2013 to reflect the growing use of cloud services and places
more emphasis on measuring and evaluating how well an organization's
ISMS is performing.

Risk assessment
~~~~~~~~~~~~~~~

A risk assessment framework identifies risks within an organization or
service, and specifies ownership of these risks, along with
implementation and mitigation strategies. Risks apply to all areas of
the service, from technical controls to environmental disaster scenarios
and human elements. For example, a malicious insider.
Risks can be rated using a variety of mechanisms. For example, likelihood
versus impact. An OpenStack deployment risk assessment can include control
gaps.

Access and log reviews
~~~~~~~~~~~~~~~~~~~~~~

Periodic access and log reviews are required to ensure authentication,
authorization, and accountability in a service deployment. Specific
guidance for OpenStack on these topics are discussed in-depth in
:ref:`monitoring-and-logging`.

The OpenStack Identity service supports Cloud Auditing Data
Federation (CADF) notification, providing auditing data for
compliance with security, operational, and business processes. For more
information, see the
`Keystone developer documentation
<https://docs.openstack.org/keystone/latest/advanced-topics/event_notifications.html#auditing-with-cadf>`_.

Backup and disaster recovery
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Disaster Recovery (DR) and Business Continuity Planning (BCP) plans are
common requirements for ISMS and compliance activities. These plans must
be periodically tested as well as documented. In OpenStack, key areas are
found in the management security domain, and anywhere that single points
of failure (SPOFs) can be identified.

Security training
~~~~~~~~~~~~~~~~~

Annual, role-specific, security training is a mandatory requirement for
almost all compliance certifications and attestations. To optimize the
effectiveness of security training, a common method is to provide role
specific training, for example to developers, operational personnel, and
non-technical employees. Additional cloud security or OpenStack security
training based on this hardening guide would be ideal.

Security reviews
~~~~~~~~~~~~~~~~

As OpenStack is a popular open source project, much of the codebase and
architecture has been scrutinized by individual contributors,
organizations, and enterprises. This can be advantageous from a security
perspective, however the need for security reviews is still a critical
consideration for service providers, as deployments vary, and security
is not always the primary concern for contributors. A comprehensive
security review process may include architectural review, threat
modeling, source code analysis and penetration testing. There are many
techniques and recommendations for conducting security reviews that can
be found publicly posted. A well-tested example is the `Microsoft
SDL <http://www.microsoft.com/security/sdl/process/release.aspx>`_,
created as part of the Microsoft Trustworthy Computing Initiative.

Vulnerability management
~~~~~~~~~~~~~~~~~~~~~~~~

Security updates are critical to any IaaS deployment, whether private or
public. Vulnerable systems expand attack surfaces, and are obvious
targets for attackers. Common scanning technologies and vulnerability
notification services can help mitigate this threat. It is important
that scans are authenticated and that mitigation strategies extend
beyond simple perimeter hardening. Multi-tenant architectures such as
OpenStack are particularly prone to hypervisor vulnerabilities, making
this a critical part of the system for vulnerability management.

Data classification
~~~~~~~~~~~~~~~~~~~

Data Classification defines a method for classifying and handling
information, often to protect customer information from accidental or
deliberate theft, loss, or inappropriate disclosure. Most commonly, this
involves classifying information as sensitive or non-sensitive, or as
personally identifiable information (PII). Depending on the context of
the deployment various other classifying criteria may be used
(government, health-care). The underlying principle is that data
classifications are clearly defined and in-use. The most common
protective mechanisms include industry standard encryption technologies.

Exception process
~~~~~~~~~~~~~~~~~

An exception process is an important component of an ISMS. When certain
actions are not compliant with security policies that an organization
has defined, they must be logged. Appropriate justification, description
and mitigation details need to be included, and signed off by
appropriate authorities. OpenStack default configurations may vary in
meeting various compliance criteria, areas that fail to meet compliance
requirements should be logged, with potential fixes considered for
contribution to the community.
