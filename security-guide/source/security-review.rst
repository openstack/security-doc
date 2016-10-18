===============
Security Review
===============

The goal of security review in the OpenStack community is to identify
weaknesses in design or implementation of OpenStack projects. While rare,
these weaknesses could potentially have catastrophic effects on the security of
an OpenStack deployment, and therefore work should be undertaken to minimize
the likelihood of these defects in released projects. The OpenStack Security
Project asserts that once a security review of a project has been completed,
the following are known and documented:

- All entry points into a system
- What assets are at risk
- Where data is persisted
- How data travels between components of the system
- Data formats and transformations
- External dependencies of the project
- An agreed set of findings and/or defects
- How the project interacts with external dependencies

A common reason to perform a security review on an OpenStack project is to
enable that project to achieve the *vulnerability:managed* governance tag. The
OpenStack Vulnerability Management Team (VMT) applies the
`vulnerability:managed tag
<https://governance.openstack.org/reference/tags/vulnerability_managed.html>`__
to projects where the report reception and disclosure of vulnerabilities is
managed by the VMT. One of the requirements for gaining the tag is that
some form of security review, audit or threat analysis has been performed on
the project.

The OpenStack Security Project (OSSP) has worked with the VMT to agree that an
architectural review of the best practice deployment for a project is an
appropriate form of security review, balancing the need for review with the
resource requirements for a project of the scale of OpenStack. Security
architecture review is also often referred to as *threat analysis*, *security
analysis* or *threat modeling*, in the context of OpenStack security review
these terms are synonymous for an architectural security review which may
identify defects in the design of a project or reference architecture, and may
lead to further investigative work to verify parts of the implementation.

There are two routes that an OpenStack project may take to complete a security
review:

#. Review by OpenStack Security Project
#. Review by a third party review body, with validation from the OpenStack
   Security Project

Security review by the OSSP is expected to be the normal route for new projects
and for cases where third parties have not performed security reviews or are
unable to share their results. Information for projects that require a security
review by the OSSP will be available in the upcoming security review process.

In cases where a security review has already been performed by a third party,
or where a project prefers to use a third party to perform their review,
information on how to take the output of that third party review and submit it
to the OSSP for validation will be available in the upcoming third party
security review process.

In either case, the requirements for documentation artefacts are similar - the
project must provide an architecture diagram for a best practise deployment.
Vulnerability scans and static analysis scans are not sufficient evidence for
a third party review, although they are strongly recommended as part of the
development cycle for all teams.

.. toctree::
   :maxdepth: 2

   security-review/architecture-page-guidance.rst
