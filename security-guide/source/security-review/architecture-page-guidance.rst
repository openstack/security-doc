==========================
Architecture page guidance
==========================

The purpose of an architecture page is to document the architecture, purpose
and security controls of a service or project. It should document the best
practice deployment of that project.

There are some key sections to the architecture page, which are explained in
more detail below:

- Title, version information, contact details
- Project description and purpose
- Primary users and use-cases
- External dependencies and associated security assumptions
- Components
- Architecture diagram
- Data assets
- Data asset impact analysis
- Interfaces


Title, version information, contact details
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section titles the architecture page, gives the status of the review
(draft, ready for review, reviewed) and captures the release and version of the
project (where relevant). It also records the PTL for the project, the
project's architect who is responsible for producing the architecture page,
diagrams and working through the review (this may or may not be the PTL), and
the security reviewer(s).


Project description and purpose
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section will contain a brief description of the project to introduce third
parties to the service. This should be a paragraph or two and can be cut/paste
from wiki or other documentation. Include links to relevant presentations and
further documentation if available.

For example:

"Anchor is a public key infrastructure (PKI) service, which uses automated
certificate request validation to automate issuing decisions. Certificates are
issued for short time periods (typically 12-48 hours) to avoid the flawed
revocation issues associated with CRLs and OCSP."


Primary users and use-cases
~~~~~~~~~~~~~~~~~~~~~~~~~~~

A list of the expected primary users of the implemented architecture and their
use-cases. 'Users' can either be actors or other services within OpenStack.

For example:

1. End users will use the system to store sensitive data, such as passphrases
   encryption keys, etc.
2. Cloud administrators will use the administrative APIs to manage resource
   quotas.


External dependencies and associated security assumptions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

External dependencies are items outside of the control of the service that are
required for its operation, and may impact the service if they were compromised
or became unavailable. These items are usually outside the control of the
developer but within the control of the deployer, or they may be operated by a
third party. Appliances should be regarded as external dependencies.

For example:

- Nova compute service depends on an external authentication and authorization
  service. In a typical deployment this dependency will be fulfilled by the
  keystone service.
- Barbican depends on the use of Hardware Security Module (HSM) appliance.


Components
~~~~~~~~~~

A list of the components of the deployed project excluding external entities.
Each component should be named and have a brief description of its purpose, and
be labeled with the primary technology used (e.g. Python, MySQL, RabbitMQ).

For example:

- keystone listener process (Python): Python process that consumes keystone
  events published by the keystone service.
- Database (MySQL): MySQL database to store barbican state data related to its
  managed entities and their metadata.


Service architecture diagram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The architecture diagram shows the logical layout of the system so the security
reviewers can step through the architecture with the project team. It is a
logical diagram which shows how the components interact, how they connect to
external entities, and where communications cross trust boundaries. Further
information on architecture diagram, including a key of symbols, will be given
in the upcoming architecture diagram guidance. Diagrams can be drawn in any
tool that can produce a diagram which uses the symbols in the key, however
`draw.io <https://draw.io>`__ is strongly recommended.

This example shows the barbican architecture diagram:

.. image:: ../figures/security_review_barbican_architecture.png


Data assets
~~~~~~~~~~~

Data assets are user data, high-value data, configuration items, authorization
tokens or other items that an attacker may target. The set of data items will
vary between projects, but in general it should be considered as classes of
data which are vital to the intended operation of the project. The level of
detail required is somewhat dependent on the context. Data can usually be
grouped, such as 'user data', 'secret data', or 'configuration files', but may
be singular, like 'admin identity token' or 'user identity token', or 'database
configuration file'.

Data assets should include a statement of where that asset is persisted.

For example:

- *Secret data* - Passphrases, Encryption Keys, RSA Keys - persisted in
  Database [PKCS#11] or HSM [KMIP] or [KMIP, Dogtag]
- *RBAC rulesets* - persisted in policy.json
- *RabbitMQ Credentials* - persisted in barbican.conf
- *keystone Event Queue Credentials* - persisted in barbican.conf
- *Middleware configuration* - persisted in paste.ini


Data asset impact analysis
~~~~~~~~~~~~~~~~~~~~~~~~~~

The data asset impact analysis breaks down the impact of the loss of
confidentiality, integrity or availability for each data asset. Project
architects should attempt to complete this, as they understand their project in
the most detail, but the OpenStack Security Project (OSSP) will work through
this with the project during the security review and are likely to add or
update the impact details.

For example:

- *RabbitMQ credentials*:

  - Integrity Failure Impact: barbican and Workers can no longer access the
    queue. Denial of service.
  - Confidentiality Failure Impact: An attacker could add new tasks to the
    queue which would be executed by workers. User quotas could be exhausted by
    an attacker. DoS. User would be unable to create genuine secrets.
  - Availability Failure Impact: barbican could no longer create new secrets
    without access to the queue.

- *keystone credentials*:

  - Integrity Failure Impact: barbican will not be able to validate user
    credentials and fail. DoS.
  - Confidentially Failure Impact: A malicious user might be able to abuse
    other OpenStack services (depending on keystone role configurations) but
    barbican is unaffected. If the service account for token validation also
    has barbican admin privileges, then a malicious user could manipulate
    barbican admin functions.
  - Availability Failure Impact: barbican will not be able to validate user
    credentials and fail. DoS.


Interfaces
~~~~~~~~~~

The interfaces listing captures interfaces within the scope of the review. This
includes  connections between blocks on the architecture diagram which cross a
trust boundary or do not use an industry standard encryption protocol such as
TLS or SSH. For each interface the following information is captured:

  - The protocol used
  - Any data assets in transit across that interface
  - Information on authentication used to connect to that interface
  - A brief description of the purpose of the interface.

This is recorded in the following format:

From->To *[Transport]*:

- Assets in flight
- Authentication?
- Description

For example:

1. Client->API Process *[TLS]*:

   - Assets in flight: User keystone credentials, plaintext secrets, HTTP verb,
     secret ID, path
   - Access to keystone credentials or plaintext secrets is considered a total
     security failure of the system - this interface must have robust
     confidentiality and integrity controls.


Resources
~~~~~~~~~

List resources relevant to the project, such as wiki pages describing its
deployment and usage, and links to code repositories and relevant
presentations.
