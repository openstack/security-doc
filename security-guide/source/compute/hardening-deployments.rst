=============================
Hardening Compute deployments
=============================

One of the main security concerns with any OpenStack deployment is the security
and controls around sensitive files, such as the :file:`nova.conf` file.
Normally contained in the :file:`/etc` directory, this configuration file
contains many sensitive options including configuration details and service
passwords. All such sensitive files should be given strict file level
permissions, and monitored for changes through file integrity monitoring (FIM)
tools such as iNotify or Samhain. These utilities will take a hash of the
target file in a known good state, and then periodically take a new hash of the
file and compare it to the known good hash. An alert can be created if it was
found to have been modified unexpectedly.

The permissions of a file can be examined my moving into the directory the file
is contained in and running the ``ls -lh`` command. This will show the
permissions, owner, and group that have access to the file, as well as other
information such as the last time the file was modified and when it was
created.

The :file:`/var/lib/nova` directory is used to hold details about the instances
on a given Compute host. This directory should be considered sensitive as well,
with strictly enforced file permissions. Additionally, it should be backed up
regularly as it contains information and metadata for the instances associated
with that host.

If your deployment does not require full virtual machine backups, we recommend
excluding the :file:`/var/lib/nova/instances` directory as it will be as large
as the combined space of each vm running on that node. If your deployment does
require full vm backups, you will need to ensure this directory is backed up
successfully.

Monitoring is a critical component of IT infrastructure, and we recommend the
`Compute logfiles
<http://docs.openstack.org/kilo/config-reference/content/section_nova-logs.html>`__
be monitored and analyzed so that meaningful alerts can be created.


OpenStack vulnerability management team
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We recommend keeping up to date on security issues and advisories as they are
published. The OpenStack Security Portal (`https://security.openstack.org
<https://security.openstack.org>`__) is the central portal where advisories,
notices, meetings, and processes can be coordinated. Additionally, the
OpenStack Vulnerability Management Team (VMT) portal
(`https://security.openstack.org/#openstack-vulnerability-management-team
<https://security.openstack.org/#openstack-vulnerability-management-team>`__)
coordinates remediation within the OpenStack project, as well as the process of
investigating reported bugs which are responsibly disclosed (privately) to the
VMT, by marking the bug as 'This bug is a security vulnerability'. Further
detail is outlined in the VMT process page
(`https://security.openstack.org/vmt-process.html#process
<https://security.openstack.org/vmt-process.html#process>`__) and results in an
OpenStack Security Advisory or OSSA. This OSSA outlines the issue and the fix,
as well as linking to both the original bug, and the location where the where
the patch is hosted.


OpenStack security notes
~~~~~~~~~~~~~~~~~~~~~~~~

Reported security bugs that are found to be the result of a misconfiguration,
or are not strictly part of OpenStack are drafted into Openstack Security Notes
or OSSNs. These include configuration issues such as ensuring Identity provider
mappings as well as non-OpenStack but critical issues such as the Bashbug/Ghost
or Venom vulnerabilities that affect the platform OpenStack utilizes. The
current set of OSSNs is in the Security Note wiki
(`https://wiki.openstack.org/wiki/Security_Notes
<https://wiki.openstack.org/wiki/Security_Notes>`__).


OpenStack-dev mailinglist
~~~~~~~~~~~~~~~~~~~~~~~~~

All bugs, OSSAs and OSSNs are publicly disseminated through the openstack-dev
mailinglist with the [security] topic in the subject line. We recommend
subscribing to this list as well as mail filtering rules that ensure OSSNs,
OSSAs, and other important advisories are not missed. The openstack-dev
mailinglist is managed through
`http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev
<http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev>`__.
The openstack-dev list has a high traffic rate, and filtering is discussed in
the thread
`http://lists.openstack.org/pipermail/openstack-dev/2013-November/019233.html
<http://lists.openstack.org/pipermail/openstack-dev/2013-November/019233.html>`__.


Hypervisor mailinglists
~~~~~~~~~~~~~~~~~~~~~~~

When implementing OpenStack, one of the core decisions is which hypervisor to
utilize. We recommend being informed of advisories pertaining to the
hypervisor(s) you have chosen. Several common hypervisor security lists are
below:

Xen:
    `http://xenbits.xen.org/xsa/ <http://xenbits.xen.org/xsa/>`__
VMWare:
    `http://blogs.vmware.com/security/ <http://blogs.vmware.com/security/>`__
Others (KVM, and more):
    `http://seclists.org/oss-sec <http://seclists.org/oss-sec>`__
