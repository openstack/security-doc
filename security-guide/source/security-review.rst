===============
Security review
===============

The goal of security review in the OpenStack community is to identify
weaknesses in design or implementation of OpenStack projects. While rare, these
weaknesses could potentially have catastrophic effects on the security of an
OpenStack deployment, and therefore work should be undertaken to minimize the
likelihood of these defects in released projects. Over the course of a security
review, the following should be known and documented:

- All entry points into a system
- What assets are at risk
- Where data is persisted
- How data travels between components of the system
- Data formats and transformations
- External dependencies of the project
- An agreed set of findings and/or defects
- How the project interacts with external dependencies

A common reason to perform a security review on an OpenStack deliverable
repository is to assist with Vulnerability Management Team (VMT) oversight. The
OpenStack VMT lists `overseen repositories
<https://security.openstack.org/repos-overseen.html>`_ where the report
reception and disclosure of vulnerabilities is managed by the VMT. While not a
strict requirement, some form of security review, audit or threat analysis
helps everyone more easily pinpoint areas where a system is more prone to
vulnerabilities and solve them before they become a problem for users.

The OpenStack VMT suggests that an architectural review of the recommended
deployment for a project is an appropriate form of security review, balancing
the need for review with the resource requirements for a project of the scale
of OpenStack. Security architecture review is also often referred to as *threat
analysis*, *security analysis* or *threat modeling*. In the context of
OpenStack security review, these terms are synonymous for an architectural
security review which may identify defects in the design of a project or
reference architecture, and may lead to further investigative work to verify
parts of the implementation.

Security review is expected to be the normal route for new projects and for
cases where third parties have not performed security reviews or are unable to
share their results. Information for projects that require a security review
will be available in the upcoming security review process.

In cases where a security review has already been performed by a third party,
or where a project prefers to use a third party to perform their review,
information on how to take the output of that third party review and submit it
for validation will be available in the upcoming third party security review
process.

In either case, the requirements for documentation artefacts are similar - the
project must provide an architecture diagram for a best practise deployment.
Vulnerability scans and static analysis scans are not sufficient evidence for
a third party review, although they are strongly recommended as part of the
development cycle for all teams.

.. toctree::
   :maxdepth: 2

   security-review/architecture-page-guidance.rst
