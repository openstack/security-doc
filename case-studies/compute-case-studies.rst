============
Case studies
============

Earlier in :doc:`../introduction/introduction-to-case-studies` we
introduced the Alice and Bob case studies where Alice is deploying a
private government cloud and Bob is deploying a public cloud each with
different security requirements. Here we discuss how Alice and Bob
would ensure that their instances are properly isolated. First we consider
hypervisor selection, and then techniques for hardening QEMU and applying
mandatory access controls.


Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

Alice chooses Xen for the hypervisor in her cloud due to a strong internal
knowledge base and a desire to use the Xen security modules (XSM) for
fine-grained policy enforcement.

Alice is willing to apply a relatively large amount of resources to software
packaging and maintenance. She will use these resources to build a highly
customized version of QEMU that has many components removed, thereby reducing
the attack surface. She will also ensure that all compiler hardening options
are enabled for QEMU. Alice accepts that these decisions will increase
long-term maintenance costs.

Alice writes XSM policies (for Xen) and SELinux policies (for Linux domain 0,
and device domains) to provide stronger isolation between the instances. Alice
also uses the Intel TXT support in Xen to measure the hypervisor launch in the
TPM.

She then ensures there are restrictive file permissions, such as 640, on all
sensitive files, such as ``nova.conf``, and directories. After outlining
a process for creating and updating 'golden images' that will be the templates
for images, she also tests and then configures the ``AvailabilityZoneFilter``
to enable regional zones, and the ``ServerGroupAffinityFilter`` with the
``AggregateIoOps`` filters to distribute load across systems.


Bob's public cloud
~~~~~~~~~~~~~~~~~~

Bob is very concerned about instance isolation since the users in a
public cloud represent anyone with a credit card, meaning they are
inherently untrusted. Bob has just started hiring the team that will
deploy the cloud, so he can tailor his candidate search for specific
areas of expertise. With this in mind, Bob chooses a hypervisor based on
its technical features, certifications, and community support. KVM has
an EAL 4+ common criteria rating, with a labeled security protection
profile (LSPP) to provide added assurance for instance isolation. This,
combined with the strong support for KVM within the OpenStack community
drives Bob's decision to use KVM. Bob weighs the added cost of
repackaging QEMU and decides that he cannot commit those resources to
the project. Fortunately, his Linux distribution has already enabled the
compiler hardening options, so he decides to use this QEMU package. Bob
decides to use AppArmor to secure the hypervisor images due to their
ease of use in a significantly large fleet. Bob considered using
GRSecurity; however, it would have required significant time to tune all
his applications to be properly covered by GRSecurity. Then, any
applications he wanted to use in the future would need to be
compatible as well.

Bob also ensures that sensitive files and folders on hypervisors are
owned by their respective services and have 640 permissions. Finally,
Bob uses the ``AvailabilityZoneFilter`` to enable his regional zones and
``JsonFilter`` to be able to add tenants through a JSON file as needed.
He also tests his scheduler filters at scale so that he does not run
into resource or filter issues.
