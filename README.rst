OpenStack Security Documentation
++++++++++++++++++++++++++++++++

This repository contains the OpenStack Security documentation.

For more details, see the `OpenStack Documentation Contributor
Guide <http://docs.openstack.org/contributor-guide/>`_.

It includes these manuals:

 * Security Guide
 * Security Notes
 * Security Threat Analysis

The Security Notes are published by the OpenStack Security Project (OSSP) to
advise users of security related issues. For more information refer
https://wiki.openstack.org/wiki/Security_Notes and
https://wiki.openstack.org/wiki/Security/Security_Note_Process.

Security Advisories are issued by the Vulnerability Management Team (VMT). For
more information about OpenStack's Vulnerability Management Team (VMT) refer
https://security.openstack.org/vmt-process.html.

Directory Structure
-------------------

Security Guide is in the directory ``security-guide``, which source files in
RST format in the directory ``security-guide/source``.

Security Threat Analysis is in the directory ``security-guide``, which source
files in RST format in the directory ``security-threat-analysis/source``.

The security notes are in the directory ``security-notes``.


Testing of changes and building of the guides
=============================================

Install the python tox package and run ``tox`` from the top-level
directory to use the same tests that are done as part of our Jenkins
gating jobs.

    tox


Contributing
============

Our community welcomes all people interested in open source cloud
computing, and encourages you to join the `OpenStack Foundation
<http://www.openstack.org/join>`_.

The best way to get involved with the community is to talk with others
online or at a meet up and offer contributions through our processes,
the `OpenStack wiki <http://wiki.openstack.org>`_, blogs, or on IRC at
``#openstack`` on ``irc.freenode.net``.

We welcome all types of contributions, from blueprint designs to
documentation to testing to deployment scripts.

If you would like to contribute to the documents, please see the
`OpenStack Documentation contributor guide
<http://docs.openstack.org/contributor-guide/>`_.


Bugs
====

Bugs should be filed on Launchpad, not GitHub:

   https://bugs.launchpad.net/openstack-manuals

If you find a security issue in OpenStack, not in the contents of the Security
Guide, please see  `How to Report Security Issues to OpenStack
<https://security.openstack.org/>`_.


Installing
==========

Refer to http://docs.openstack.org/security-guide to see where these documents
are published and to learn more about the OpenStack Security Guide.
