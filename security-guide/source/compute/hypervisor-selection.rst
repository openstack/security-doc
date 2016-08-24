====================
Hypervisor selection
====================

Hypervisors in OpenStack
~~~~~~~~~~~~~~~~~~~~~~~~

Whether OpenStack is deployed within private data centers or as a public cloud
service, the underlying virtualization technology provides enterprise-level
capabilities in the realms of scalability, resource efficiency, and uptime.
While such high-level benefits are generally available across many
OpenStack-supported hypervisor technologies, there are significant differences
in the security architecture and features for each hypervisor, particularly
when considering the security threat vectors which are unique to elastic
OpenStack environments. As applications consolidate into single
Infrastructure-as-a-Service (:term:`IaaS`) platforms, instance isolation at
the hypervisor level becomes paramount. The requirement for secure isolation
holds true across commercial, government, and military communities.

Within the OpenStack framework, you can choose among many hypervisor platforms
and corresponding OpenStack plug-ins to optimize your cloud environment. In the
context of this guide, hypervisor selection considerations are highlighted as
they pertain to feature sets that are critical to security. However, these
considerations are not meant to be an exhaustive investigation into the pros
and cons of particular hypervisors. NIST provides additional guidance in
Special Publication 800-125, "*Guide to Security for Full Virtualization
Technologies*".

Selection criteria
~~~~~~~~~~~~~~~~~~

As part of your hypervisor selection process, you must consider a number of
important factors to help increase your security posture. Specifically, you
must become familiar with these areas:

* Team expertise
* Product or project maturity
* Common criteria
* Certifications and attestations
* Hardware concerns
* Hypervisor vs. baremetal
* Additional security features

Additionally, the following security-related criteria are highly encouraged to
be evaluated when selecting a hypervisor for OpenStack deployments:
* Has the hypervisor undergone Common Criteria certification? If so, to what
levels?
* Is the underlying cryptography certified by a third-party?

Team expertise
~~~~~~~~~~~~~~

Most likely, the most important aspect in hypervisor selection is the expertise
of your staff in managing and maintaining a particular hypervisor platform. The
more familiar your team is with a given product, its configuration, and its
eccentricities, the fewer the configuration mistakes. Additionally, having
staff expertise spread across an organization on a given hypervisor increases
availability of your systems, allows segregation of duties, and mitigates
problems in the event that a team member is unavailable.

Product or project maturity
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The maturity of a given hypervisor product or project is critical to your
security posture as well. Product maturity has a number of effects once you
have deployed your cloud:

* Availability of expertise
* Active developer and user communities
* Timeliness and availability of updates
* Incidence response

One of the biggest indicators of a hypervisor's maturity is the size and
vibrancy of the community that surrounds it. As this concerns security, the
quality of the community affects the availability of expertise if you need
additional cloud operators. It is also a sign of how widely deployed the
hypervisor is, in turn leading to the battle readiness of any reference
architectures and best practices.

Further, the quality of community, as it surrounds an open source hypervisor
like KVM or Xen, has a direct impact on the timeliness of bug fixes and
security updates. When investigating both commercial and open source
hypervisors, you must look into their release and support cycles as well as
the time delta between the announcement of a bug or security issue and a patch
or response. Lastly, the supported capabilities of OpenStack compute vary
depending on the hypervisor chosen. See the `OpenStack Hypervisor Support
Matrix <https://wiki.openstack.org/wiki/HypervisorSupportMatrix>`__ for
OpenStack compute feature support by hypervisor.

Certifications and attestations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

One additional consideration when selecting a hypervisor is the availability of
various formal certifications and attestations. While they may not be
requirements for your specific organization, these certifications and
attestations speak to the maturity, production readiness, and thoroughness of
the testing a particular hypervisor platform has been subjected to.

Common criteria
~~~~~~~~~~~~~~~

Common Criteria is an internationally standardized software evaluation process,
used by governments and commercial companies to validate software technologies
perform as advertised. In the government sector, NSTISSP No. 11 mandates that
U.S. Government agencies only procure software which has been Common Criteria
certified, a policy which has been in place since July 2002. It should be
specifically noted that OpenStack has not undergone Common Criteria
certification, however many of the available hypervisors have.

In addition to validating a technologies capabilities, the Common Criteria
process evaluates *how*  technologies are developed.

* How is source code management performed?
* How are users granted access to build systems?
* Is the technology cryptographically signed before distribution?

The KVM hypervisor has been Common Criteria certified through the U.S.
Government and commercial distributions, which have been validated to separate
the runtime environment of virtual machines from each other, providing
foundational technology to enforce instance isolation. In addition to  virtual
machine isolation, KVM has been Common Criteria certified to

.. code::

   "provide system-inherent separation mechanisms to the resources of virtual
   machines. This separation ensures that large software component used for
   virtualizing and simulating devices executing for each  virtual machine
   cannot interfere with each other. Using the SELinux multi-category
   mechanism, the virtualization and simulation software instances are
   isolated. The virtual machine management framework configures SELinux
   multi-category settings transparently to the administrator"

While many hypervisor vendors, such as Red Hat, Microsoft, and VMware have
achieved Common Criteria Certification their underlying certified feature set
differs. It is recommended to evaluate vendor claims to ensure they minimally
satisfy the following requirements:

.. list-table::
   :widths: 20 80
   :header-rows: 1

   * - Identification and Authentication
     - Identification and authentication using pluggable authentication modules
       (PAM) based upon user passwords. The quality of the passwords used can
       be enforced through configuration options.
   * - Audit
     - The system provides the capability to audit a large number of events
       including individual system calls as well as events generated by trusted
       processes. Audit data is collected in regular files in ASCII format. The
       system provides a program for the purpose of searching the audit records.
       The system administrator can define a rule base to restrict auditing to
       the events they are interested in. This includes the ability to restrict
       auditing to specific events, specific users, specific objects or a
       combination of all of this.
       Audit records can be transferred to a remote audit daemon.
   * - Discretionary Access Control
     - :term:`Discretionary Access Control (DAC)` restricts access to
       file system objects based on :term:`ACL <access control list (ACL)>`
       that include the standard UNIX permissions for user,
       group and others. Access control mechanisms also protect IPC objects
       from unauthorized access.
       The system includes the ext4 file system, which supports POSIX ACLs.
       This allows defining access rights to files within this type of file
       system down to the granularity of a single user.
   * - Mandatory Access Control
     - Mandatory Access Control (MAC) restricts access to objects based on
       labels assigned to subjects and objects. Sensitivity labels are
       automatically attached to processes and objects. The access control
       policy enforced using these labels is derived from the
       :term:`Bell-LaPadula model`.
       SELinux categories are attached to virtual machines and its resources.
       The access control policy enforced using these categories grant virtual
       machines access to resources if the category of the virtual machine is
       identical to the category of the accessed resource.
       The TOE implements non-hierarchical categories to control access to
       virtual machines.
   * - Role-Based Access Control
     - Role-based access control (RBAC) allows separation of roles to eliminate
       the need for an all-powerful system administrator.
   * - Object Reuse
     - File system objects and memory and IPC objects are cleared before they
       can be reused by a process belonging to a different user.
   * - Security Management
     - The management of the security critical parameters of the system is
       performed by administrative users. A set of commands that require root
       privileges (or specific roles when RBAC is used) are used for system
       management. Security parameters are stored in specific files that are
       protected by the access control mechanisms of the system against
       unauthorized access by users that are not administrative users.
   * - Secure Communication
     - The system supports the definition of trusted channels using SSH.
       Password based authentication is supported. Only a restricted number of
       cipher suites are supported for those protocols in the evaluated
       configuration.
   * - Storage Encryption
     - The system supports encrypted block devices to provide storage
       confidentiality via dm_crypt.
   * - TSF Protection
     - While in operation, the kernel software and data are protected by the
       hardware memory protection mechanisms. The memory and process management
       components of the kernel ensure a user process cannot access kernel
       storage or storage belonging to other processes.
       Non-kernel TSF software and data are protected by DAC and process
       isolation mechanisms. In the evaluated configuration, the reserved user
       ID root owns the directories and files that define the TSF
       configuration. In general, files and directories containing internal TSF
       data, such as configuration files and batch job queues, are also
       protected from reading by DAC permissions.
       The system and the hardware and firmware components are required to be
       physically protected from unauthorized access. The system kernel
       mediates all access to the hardware mechanisms themselves, other than
       program visible CPU instruction functions.
       In addition, mechanisms for protection against stack overflow attacks
       are provided.

Cryptography standards
~~~~~~~~~~~~~~~~~~~~~~

Several cryptography algorithms are available within OpenStack for
identification and authorization, data transfer and protection of data at rest.
When selecting a hypervisor, the following are recommended algorithms and
implementation standards to ensure the virtualization layer supports:

.. list-table::
   :header-rows: 1
   :widths: 15 10 20 50 20

   * - Algorithm
     - Key length
     - Intended purpose
     - Security function
     - Implementation standard
   * - AES
     - 128, 192, or 256 bits
     - Encryption / decryption
     - Protected data transfer, protection for data at rest
     - `RFC 4253 <http://www.ietf.org/rfc/rfc4253.txt>`__
   * - TDES
     - 168 bits
     - Encryption / decryption
     - Protected data transfer
     - `RFC 4253 <http://www.ietf.org/rfc/rfc4253.txt>`__
   * - RSA
     - 1024, 2048, or 3072 bits
     - Authentication, key exchange
     - Identification and authentication, protected data transfer
     - `U.S. NIST FIPS PUB 186-3
       <http://csrc.nist.gov/publications/fips/fips186-3/fips_186-3.pdf>`__
   * - DSA
     - L=1024, N=160 bits
     - Authentication, key exchange
     - Identification and authentication, protected data transfer
     - `U.S. NIST FIPS PUB 186-3
       <http://csrc.nist.gov/publications/fips/fips186-3/fips_186-3.pdf>`__
   * - Serpent
     - 128, 192, or 256 bits
     - Encryption / decryption
     - Protection of data at rest
     - `http://www.cl.cam.ac.uk/~rja14/Papers/serpent.pdf
       <http://www.cl.cam.ac.uk/~rja14/Papers/serpent.pdf>`__
   * - Twofish
     - 128, 192, or 256 bit
     - Encryption / decryption
     - Protection of data at rest
     - `https://www.schneier.com/paper-twofish-paper.html
       <https://www.schneier.com/paper-twofish-paper.html>`__
   * - SHA-1
     - -
     - Message Digest
     - Protection of data at rest, protected data transfer
     - `U.S. NIST FIPS PUB 180-3
       <http://csrc.nist.gov/publications/fips/fips180-3/fips180-3_final.pdf>`__
   * - SHA-2 (224, 256, 384, or 512 bits)
     - -
     - Message Digest
     - Protection for data at rest, identification and authentication
     - `U.S. NIST FIPS PUB 180-3
       <http://csrc.nist.gov/publications/fips/fips180-3/fips180-3_final.pdf>`__

FIPS 140-2
~~~~~~~~~~

In the United States the National Institute of Science and Technology (NIST)
certifies cryptographic algorithms through a process known the Cryptographic
Module Validation Program. NIST certifies algorithms for conformance against
Federal Information Processing Standard 140-2 (FIPS 140-2), which ensures:

.. code::

   *Products validated as conforming to FIPS 140-2 are accepted by the Federal
   agencies of both countries [United States and Canada] for the protection of
   sensitive information (United States) or Designated Information (Canada).
   The goal of the CMVP is to promote the use of validated cryptographic
   modules and provide Federal agencies with a security metric to use in
   procuring equipment containing validated cryptographic modules.*

When evaluating base hypervisor technologies, consider if the hypervisor has
been certified against FIPS 140-2. Not only is conformance against FIPS 140-2
mandated per U.S. Government policy, formal certification indicates that a
given implementation of a cryptographic algorithm has been reviewed for
conformance against module specification, cryptographic module ports and
interfaces; roles, services, and authentication; finite state model; physical
security; operational environment; cryptographic key management;
electromagnetic interference/electromagnetic compatibility  (EMI/EMC);
self-tests; design assurance; and mitigation of other attacks.

Hardware concerns
~~~~~~~~~~~~~~~~~

Further, when you evaluate a hypervisor platform, consider the supportability
of the hardware on which the hypervisor will run. Additionally, consider the
additional features available in the hardware and how those features are
supported by the hypervisor you chose as part of the OpenStack deployment. To
that end, hypervisors each have their own hardware compatibility lists (HCLs).
When selecting compatible hardware it is important to know in advance which
hardware-based virtualization technologies are important from a security
perspective.

.. list-table::
   :header-rows: 1
   :widths: 20 20 20

   * - Description
     - Technology
     - Explanation
   * - I/O MMU
     - VT-d / AMD-Vi
     - Required for protecting PCI-passthrough
   * - Intel Trusted Execution Technology
     - Intel TXT / SEM
     - Required for dynamic attestation services
   * - PCI-SIG I/O virtualization
     - SR-IOV, MR-IOV, ATS
     - Required to allow secure sharing of PCI Express devices
   * - Network virtualization
     - VT-c
     - Improves performance of network I/O on hypervisors


Hypervisor vs. baremetal
~~~~~~~~~~~~~~~~~~~~~~~~

It is important to recognize the difference between using LXC (Linux
Containers) or baremetal systems vs using a hypervisor like KVM. Specifically,
the focus of this security guide is largely based on having a hypervisor and
virtualization platform. However, should your implementation require the use of
a baremetal or LXC environment, you must pay attention to the particular
differences in regard to deployment of that environment.

In particular, you must assure your end users that the node has been properly
sanitized of their data prior to re-provisioning. Additionally, prior to
reusing a node, you must provide assurances that the hardware has not been
tampered or otherwise compromised.

.. note::

   While OpenStack has a baremetal project, a discussion of the particular
   security implications of running baremetal is beyond the scope of this book.

Finally, due to the time constraints around a book sprint, the team chose to
use KVM as the hypervisor in our example implementations and architectures.

.. note::

   There is an OpenStack Security Note pertaining to the `Use of LXC in
   Compute <https://bugs.launchpad.net/ossn/+bug/1098582>`__.


Hypervisor memory optimization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Many hypervisors use memory optimization techniques to overcommit memory to
guest virtual machines. This is a useful feature that allows you to deploy very
dense compute clusters. One way to achieve this is through de-duplication or
"sharing" of memory pages. When two virtual machines have identical data in
memory, there are advantages to having them reference the same memory.

Typically this is achieved through Copy-On-Write (COW) mechanisms. These
mechanisms have been shown to be vulnerable to side-channel attacks where one
VM can infer something about the state of another and might not be appropriate
for multi-tenant environments where not all tenants are trusted or share the
same levels of trust.

KVM Kernel Samepage Merging
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced into the Linux kernel in version 2.6.32, Kernel Samepage Merging
(KSM) consolidates identical memory pages between Linux processes. As each
guest VM under the KVM hypervisor runs in its own process, KSM can be used to
optimize memory use between VMs.

XEN transparent page sharing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

XenServer 5.6 includes a memory overcommitment feature named Transparent Page
Sharing (TPS). TPS scans memory in 4 KB chunks for any duplicates. When found,
the Xen Virtual Machine Monitor (VMM) discards one of the duplicates and
records the reference of the second one.

Security considerations for memory optimization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Traditionally, memory de-duplication systems are vulnerable to side channel
attacks. Both KSM and TPS have demonstrated to be vulnerable to some form of
attack. In academic studies attackers were able to identify software packages
and versions running on neighboring virtual machines as well as software
downloads and other sensitive information through analyzing memory access
times on the attacker VM.

If a cloud deployment requires strong separation of tenants, as is the
situation with public clouds and some private clouds, deployers should consider
disabling TPS and KSM memory optimizations.

Additional security features
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Another thing to look into when selecting a hypervisor platform is the
availability of specific security features. In particular, we are referring to
features like Xen Server's XSM or Xen Security Modules, sVirt, Intel TXT, and
AppArmor. The presence of these features increase your security profile as well
as provide a good foundation.

The following table calls out these features by common hypervisor platforms.

.. list-table::
   :header-rows: 1

   * -
     - XSM
     - sVirt
     - TXT
     - AppArmor
     - cgroups
     - MAC Policy
   * - KVM
     -
     - X
     - X
     - X
     - X
     - X
   * - Xen
     - X
     -
     - X
     -
     -
     -
   * - ESXi
     -
     -
     - X
     -
     -
     -
   * - Hyper-V
     -
     -
     -
     -
     -
     -

MAC Policy: Mandatory Access Control; may be implemented with SELinux or other
operating systems

\* Features in this table might not be applicable to all hypervisors or
directly mappable between hypervisors.

Bibliography
~~~~~~~~~~~~

* Sunar, Eisenbarth, Inci, Gorka Irazoqui Apecechea. Fine Grain Cross-VM
  Attacks on Xen and VMware are possible!. 2014.
  `https://eprint.iacr.org/2014/248.pfd
  <https://eprint.iacr.org/2014/248.pdf>`__
* Artho, Yagi, Iijima, Kuniyasu Suzaki. Memory Deduplication as a Threat to
  the Guest OS. 2011.
  `https://staff.aist.go.jp/c.artho/papers/EuroSec2011-suzaki.pdf
  <https://staff.aist.go.jp/c.artho/papers/EuroSec2011-suzaki.pdf>`__
* KVM: Kernal-based Virtual Machine. Kernal Samepage Merging. 2010.
  `http://www.linux-kvm.org/page/KSM <http://www.linux-kvm.org/page/KSM>`__
* Xen Project, Xen Security Modules: XSM-FLASK. 2014.
  `http://wiki.xen.org/wiki/Xen_Security_Modules_:_XSM-FLASK
  <http://wiki.xen.org/wiki/Xen_Security_Modules_:_XSM-FLASK>`__
* SELinux Project, SVirt. 2011.
  `http://selinuxproject.org/page/SVirt
  <http://selinuxproject.org/page/SVirt>`__
* Intel.com, Trusted Compute Pools with Intel Trusted Execution Technology
  (Intel TXT).
  `http://www.intel.com/txt <http://www.intel.com/txt>`__
* AppArmor.net, AppArmor Main Page. 2011.
  `http://wiki.apparmor.net/index.php/Main_Page
  <http://wiki.apparmor.net/index.php/Main_Page>`__
* Kernel.org, CGroups. 2004.
  `https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt
  <https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt>`__
* Computer Security Resource Centre. Guide to Security for Full Virtualization
  Technologies. 2011.
  `http://csrc.nist.gov/publications/nistpubs/800-125/SP800-125-final.pdf
  <http://csrc.nist.gov/publications/nistpubs/800-125/SP800-125-final.pdf>`__
* National Information Assurance Partnership, National Security
  Telecommunications and Information Systems Security Policy. 2003.
  `http://www.niap-ccevs.org/cc-scheme/nstissp_11_revised_factsheet.pdf
  <http://www.niap-ccevs.org/cc-scheme/nstissp_11_revised_factsheet.pdf>`__
