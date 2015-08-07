=============================
Continuous systems management
=============================

A cloud will always have bugs. Some of these will be security problems.
For this reason, it is critically important to be prepared to apply
security updates and general software updates. This involves smart use
of configuration management tools, which are discussed below. This also
involves knowing when an upgrade is necessary.

Vulnerability management
~~~~~~~~~~~~~~~~~~~~~~~~

For announcements regarding security relevant changes, subscribe to the
`OpenStack Announce mailing
list <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-announce>`__.
The security notifications are also posted through the downstream
packages, for example, through Linux distributions that you may be
subscribed to as part of the package updates.

The OpenStack components are only a small fraction of the software in a
cloud. It is important to keep up to date with all of these other
components, too. While certain data sources will be deployment specific,
it is important that a cloud administrator subscribe to the necessary
mailing lists in order to receive notification of any security updates
applicable to the organization's environment. Often this is as simple as
tracking an upstream Linux distribution.

.. note::

    OpenStack releases security information through two channels.

    -  OpenStack Security Advisories (OSSA) are created by the OpenStack
       Vulnerability Management Team (VMT). They pertain to security
       holes in core OpenStack services. More information on the VMT can
       be found here:
       https://wiki.openstack.org/wiki/Vulnerability_Management

    -  OpenStack Security Notes (OSSN) are created by the OpenStack
       Security Group (OSSG) to support the work of the VMT. OSSN
       address issues in supporting software and common deployment
       configurations. They are referenced throughout this guide.
       Security Notes are archived at https://launchpad.net/ossn/

Triage
------

After you are notified of a security update, the next step is to
determine how critical this update is to a given cloud deployment. In
this case, it is useful to have a pre-defined policy. Existing
vulnerability rating systems such as the common vulnerability scoring
system (CVSS) v2 do not properly account for cloud deployments.

In this example we introduce a scoring matrix that places
vulnerabilities in three categories: Privilege Escalation, Denial of
Service and Information Disclosure. Understanding the type of
vulnerability and where it occurs in your infrastructure will enable you
to make reasoned response decisions.

Privilege Escalation describes the ability of a user to act with the
privileges of some other user in a system, bypassing appropriate
authorization checks. A guest user performing an operation that allows
them to conduct unauthorized operations with the privileges of an
administrator is an example of this type of vulnerability.

Denial of Service refers to an exploited vulnerability that may cause
service or system disruption. This includes both distributed attacks to
overwhelm network resources, and single-user attacks that are typically
caused through resource allocation bugs or input induced system failure
flaws.

Information Disclosure vulnerabilities reveal information about your
system or operations. These vulnerabilities range from debugging
information disclosure, to exposure of critical security data, such as
authentication credentials and passwords.

.. list-table::
   :header-rows: 2
   :widths: 40 20 20 20 20
   :stub-columns: 1

   * -
     - Attacker position / Privilege level
     -
     -
     -

   * -
     - External
     - Cloud user
     - Cloud admin
     - Control plane

   * - Privilege elevation (3 levels)
     - Critical
     - n/a
     - n/a
     - n/a

   * - Privilege elevation (2 levels)
     - Critical
     - Critical
     - n/a
     - n/a

   * - Privilege elevation (1 level)
     - Critical
     - Critical
     - Critical
     - n/a

   * - Denial of service
     - High
     - Medium
     - Low
     - Low

   * - Information disclosure
     - Critical / high
     - Critical / high
     - Medium / low
     - Low


This table illustrates a generic approach to measuring the impact of a
vulnerability based on where it occurs in your deployment and the
effect. For example, a single level privilege escalation on a Compute
API node potentially allows a standard user of the API to escalate to
have the same privileges as the root user on the node.

We suggest that cloud administrators use this table as a model to help
define which actions to take for the various security levels. For
example, a critical-level security update might require the cloud to be
upgraded quickly whereas a low-level update might take longer to be
completed.

Testing the updates
-------------------

You should test any update before you deploy it in a production
environment. Typically this requires having a separate test cloud setup
that first receives the update. This cloud should be as close to the
production cloud as possible, in terms of software and hardware. Updates
should be tested thoroughly in terms of performance impact, stability,
application impact, and more. Especially important is to verify that the
problem theoretically addressed by the update, such as a specific
vulnerability, is actually fixed.

Deploying the updates
---------------------

Once the updates are fully tested, they can be deployed to the
production environment. This deployment should be fully automated using
the configuration management tools described below.

Configuration management
~~~~~~~~~~~~~~~~~~~~~~~~

A production quality cloud should always use tools to automate
configuration and deployment. This eliminates human error, and allows
the cloud to scale much more rapidly. Automation also helps with
continuous integration and testing.

When building an OpenStack cloud it is strongly recommended to approach
your design and implementation with a configuration management tool or
framework in mind. Configuration management allows you to avoid the many
pitfalls inherent in building, managing, and maintaining an
infrastructure as complex as OpenStack. By producing the manifests,
cookbooks, or templates required for a configuration management utility,
you are able to satisfy a number of documentation and regulatory
reporting requirements. Further, configuration management can also
function as part of your business continuity plan (BCP) and data
recovery (DR) plans wherein you can rebuild a node or service back to a
known state in a DR event or given a compromise.

Additionally, when combined with a version control system such as Git or
SVN, you can track changes to your environment over time and re-mediate
unauthorized changes that may occur. For example, a :file:`nova.conf`
file or other configuration file falls out of compliance with your
standard, your configuration management tool can revert or replace the
file and bring your configuration back into a known state. Finally a
configuration management tool can also be used to deploy updates;
simplifying the security patch process. These tools have a broad range
of capabilities that are useful in this space. The key point for
securing your cloud is to choose a tool for configuration management and
use it.

There are many configuration management solutions; at the time of this
writing there are two in the marketplace that are robust in their
support of OpenStack environments: :term:`Chef` and :term:`Puppet`. A
non-exhaustive listing of tools in this space is provided below:

-  Chef

-  Puppet

-  Salt Stack

-  Ansible

Policy changes
--------------

Whenever a policy or configuration management is changed, it is good
practice to log the activity, and backup a copy of the new set. Often,
such policies and configurations are stored in a version controlled
repository such as Git.

Secure backup and recovery
~~~~~~~~~~~~~~~~~~~~~~~~~~

It is important to include Backup procedures and policies in the overall
System Security Plan. For a good overview of OpenStack's Backup and
Recovery capabilities and procedures, please refer to the OpenStack
Operations Guide.

Security considerations
-----------------------

-  Ensure only authenticated users and backup clients have access to the
   backup server.

-  Use data encryption options for storage and transmission of backups.

-  Use a dedicated and hardened backup servers. The logs for the backup
   server must be monitored daily and accessible by only few
   individuals.

-  Test data recovery options regularly. One of the things that can be
   restored from secured backups is the images. In case of a compromise,
   the best practice would be to terminate running instances immediately
   and then relaunch the instances from the images in the secured backup
   repository.

References
----------

-  OpenStack Operations Guide on `backup and
   recovery <http://docs.openstack.org/openstack-ops/content/backup_and_recovery.html>`__

-  http://www.sans.org/reading_room/whitepapers/backup/security-considerations-enterprise-level-backups_515

-  `OpenStack Security Primer <http://www.music-piracy.com/?p=494>`__,
   an entry in the music piracy blog by a former member of the original
   NASA project team that created nova

Security auditing tools
~~~~~~~~~~~~~~~~~~~~~~~

Security auditing tools can complement the configuration management
tools. Security auditing tools automate the process of verifying that a
large number of security controls are satisfied for a given system
configuration. These tools help to bridge the gap from security
configuration guidance documentation (for example, the STIG and NSA
Guides) to a specific system installation. For example,
`SCAP <https://fedorahosted.org/scap-security-guide/>`__ can compare a
running system to a pre-defined profile. SCAP outputs a report detailing
which controls in the profile were satisfied, which ones failed, and
which ones were not checked.

Combining configuration management and security auditing tools creates a
powerful combination. The auditing tools will highlight deployment
concerns. And the configuration management tools simplify the process of
changing each system to address the audit concerns. Used together in
this fashion, these tools help to maintain a cloud that satisfies
security requirements ranging from basic hardening to compliance
validation.

Configuration management and security auditing tools will introduce
another layer of complexity into the cloud. This complexity brings
additional security concerns with it. We view this as an acceptable risk
trade-off, given their security benefits. Securing the operational use
of these tools is beyond the scope of this guide.
