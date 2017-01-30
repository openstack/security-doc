=====================
Management interfaces
=====================

It is necessary for administrators to perform command and control over
the cloud for various operational functions. It is important these
command and control facilities are understood and secured.

OpenStack provides several management interfaces for operators and
tenants:

-  OpenStack dashboard (horizon)

-  OpenStack API

-  :term:`Secure shell (SSH)<secure shell (SSH)>`

-  OpenStack management utilities such as nova-manage and glance-manage

-  Out-of-band management interfaces, such as IPMI

Dashboard
~~~~~~~~~

The OpenStack dashboard (horizon) provides administrators and tenants
with a web-based graphical interface to provision and access cloud-based
resources. The dashboard communicates with the back-end services through
calls to the OpenStack API.

Capabilities
------------

-  As a cloud administrator, the dashboard provides an overall view of
   the size and state of your cloud. You can create users and
   tenants/projects, assign users to tenant/projects and set limits on
   the resources available for them.

-  The dashboard provides tenant-users a self-service portal to
   provision their own resources within the limits set by
   administrators.

-  The dashboard provides GUI support for routers and load-balancers.
   For example, the dashboard now implements all of the main Networking
   features.

-  It is an extensible :term:`Django` web application that
   allows easy plug-in of third-party products and services, such as
   billing, monitoring, and additional management tools.

-  The dashboard can also be branded for service providers and other
   commercial vendors.

Security considerations
-----------------------

-  The dashboard requires cookies and JavaScript to be enabled in the
   web browser.

-  The web server that hosts the dashboard should be configured for TLS
   to ensure data is encrypted.

-  Both the horizon web service and the OpenStack API it uses to
   communicate with the back end are susceptible to web attack vectors
   such as denial of service and must be monitored.

-  It is now possible (though there are numerous deployment/security
   implications) to upload an image file directly from a user's hard
   disk to OpenStack Image service through the dashboard. For
   multi-gigabyte images it is still strongly recommended that the
   upload be done using the ``glance`` CLI.

-  Create and manage security groups through dashboard. The security
   groups allows L3-L4 packet filtering for security policies to protect
   virtual machines.

Bibliography
------------

OpenStack.org, ReleaseNotes/Liberty. 2015.
`OpenStack Liberty Release Notes <https://wiki.openstack.org/wiki/ReleaseNotes/Liberty>`__

OpenStack API
~~~~~~~~~~~~~

The OpenStack API is a RESTful web service endpoint to access, provision
and automate cloud-based resources. Operators and users typically access
the API through command-line utilities (for example, ``nova`` or
``glance``), language-specific libraries, or third-party tools.

Capabilities
------------

-  To the cloud administrator, the API provides an overall view of the
   size and state of the cloud deployment and allows the creation of
   users, tenants/projects, assigning users to tenants/projects, and
   specifying resource quotas on a per tenant/project basis.

-  The API provides a tenant interface for provisioning, managing, and
   accessing their resources.

Security considerations
-----------------------

-  The API service should be configured for TLS to ensure data is
   encrypted.

-  As a web service, OpenStack API is susceptible to familiar web site
   attack vectors such as denial of service attacks.

Secure shell (SSH)
~~~~~~~~~~~~~~~~~~

It has become industry practice to use secure shell (SSH) access for the
management of Linux and Unix systems. SSH uses secure cryptographic
primitives for communication. With the scope and importance of SSH in
typical OpenStack deployments, it is important to understand best
practices for deploying SSH.

Host key fingerprints
---------------------

Often overlooked is the need for key management for SSH hosts. As most
or all hosts in an OpenStack deployment will provide an SSH service, it
is important to have confidence in connections to these hosts. It cannot
be understated that failing to provide a reasonably secure and
accessible method to verify SSH host key fingerprints is ripe for abuse
and exploitation.

All SSH daemons have private host keys and, upon connection, offer a
host key fingerprint. This host key fingerprint is the hash of an
unsigned public key. It is important these host key fingerprints are
known in advance of making SSH connections to those hosts. Verification
of host key fingerprints is instrumental in detecting man-in-the-middle
attacks.

Typically, when an SSH daemon is installed, host keys will be generated.
It is necessary that the hosts have sufficient entropy during host key
generation. Insufficient entropy during host key generation can result
in the possibility to eavesdrop on SSH sessions.

Once the SSH host key is generated, the host key fingerprint should be
stored in a secure and queryable location. One particularly convenient
solution is DNS using SSHFP resource records as defined in RFC-4255. For
this to be secure, it is necessary that DNSSEC be deployed.

Management utilities
~~~~~~~~~~~~~~~~~~~~

The OpenStack Management Utilities are open-source Python command-line
clients that make API calls. There is a client for each OpenStack
service (for example, nova, glance). In addition to the standard CLI
client, most of the services have a management command-line utility
which makes direct calls to the database. These dedicated management
utilities are slowly being deprecated.

Security considerations
-----------------------

-  The dedicated management utilities (\*-manage) in some cases use the
   direct database connection.

-  Ensure that the .rc file which has your credential information is
   secured.

Bibliography
------------

OpenStack.org, OpenStack End User Guide section. 2016.
`OpenStack command-line clients overview  <https://docs.openstack.org/user-guide/common/cli_overview.html>`__

OpenStack.org, Set environment variables using the OpenStack RC file. 2016.
`Download and source the OpenStack RC file <https://docs.openstack.org/user-guide/common/cli_set_environment_variables_using_openstack_rc.html#download-and-source-the-openstack-rc-file>`__

Out-of-band management interface
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack management relies on out-of-band management interfaces such as
the IPMI protocol to access into nodes running OpenStack components.
IPMI is a very popular specification to remotely manage, diagnose, and
reboot servers whether the operating system is running or the system has
crashed.

Security considerations
-----------------------

-  Use strong passwords and safeguard them, or use client-side TLS
   authentication.

-  Ensure that the network interfaces are on their own
   private(management or a separate) network. Segregate management
   domains with firewalls or other network gear.

-  If you use a web interface to interact with the
   :term:`BMC <BMC (Baseboard Management Controller)>`/IPMI,
   always use the TLS interface, such as HTTPS or port 443.
   This TLS interface should **NOT** use self-signed certificates,
   as is often default, but should have trusted certificates using
   the correctly defined fully qualified domain names (FQDNs).

-  Monitor the traffic on the management network. The anomalies might be
   easier to track than on the busier compute nodes.

Out of band management interfaces also often include graphical machine
console access. It is often possible, although not necessarily default,
that these interfaces are encrypted. Consult with your system software
documentation for encrypting these interfaces.

Bibliography
------------

SANS Technology Institute, InfoSec Handlers Diary Blog. 2012.
`Hacking servers that are turned off <https://isc.sans.edu/diary/IPMI%3A+Hacking+servers+that+are+turned+%22off%22/13399>`__
