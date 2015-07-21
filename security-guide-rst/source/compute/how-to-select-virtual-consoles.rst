==============================
How to select virtual consoles
==============================

One decision a cloud architect will need to make regarding Compute service
configuration is whether to use :term:`VNC <Virtual Network Computing (VNC)>`
or :term:`SPICE`. Below we provide some details on the differences between
these options.

Virtual Network Computer (VNC)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack can be configured to provide remote desktop console access to
instances for tenants and/or administrators using the Virtual Network Computer
(VNC) protocol.

Capabilities
------------

#. The OpenStack dashboard (horizon) can provide a VNC console for instances
   directly on the web page using the HTML5 noVNC client. This requires the
   *nova-novncproxy* service to bridge from the public network to the
   management network.
#. The ``nova`` command-line utility can return a URL for the VNC console for
   access by the *nova* Java VNC client. This requires the *nova-xvpvncproxy*
   service to bridge from the public network to the management network.

Security considerations
-----------------------

#. The *nova-novncproxy* and *nova-xvpvncproxy* services by default open
   public-facing ports that are token authenticated.
#. By default, the remote desktop traffic is not encrypted. TLS can be enabled
   to encrypt the VNC traffic. Please refer to `Introduction to TLS and SSL
   <introduction-to-ssl-tls>`__ for appropriate recommendations.

Bibliography
------------

#. blog.malchuk.ru, OpenStack VNC Security. 2013. `Secure Connections to VNC
   ports <"http://blog.malchuk.ru/2013/05/21/47>`__
#. OpenStack Mailing List, [OpenStack] nova-novnc SSL configuration - Havana.
   2014.
   `OpenStack nova-novnc SSL Configuration
   <http://lists.openstack.org/pipermail/openstack/2014-February/005357.html>`__
#. Redhat.com/solutions, Using SSL Encryption with OpenStack nova-novacproxy.
   2014.
   `OpenStack nova-novncproxy SSL encryption <https://access.redhat.com/solutions/514143>`__

Simple Protocol for Independent Computing Environments (SPICE)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As an alternative to VNC, OpenStack provides remote desktop access to guest
virtual machines using the Simple Protocol for Independent Computing
Environments (SPICE) protocol.

Capabilities
------------

#. SPICE is supported by the OpenStack dashboard (horizon) directly on the
   instance web page. This requires the *nova-spicehtml5proxy* service.
#. The nova command-line utility can return a URL for SPICE console for access
   by a SPICE-html client.

Limitations
-----------

#. Although SPICE has many advantages over VNC, the spice-html5 browser
   integration currently doesn't really allow admins to take advantage of any
   of the benefits. To take advantage of SPICE features like multi-monitor,
   USB pass through, etc. admins are recommended to use a standalone SPICE
   client within the Management Network.

Security considerations
-----------------------

#. The *nova-spicehtml5proxy* service by default opens public-facing ports that
   are token authenticated.
#. The functionality and integration are still evolving. We will access the
   features in the next release and make recommendations.
#. As is the case for VNC, at this time we recommend using SPICE from the
   management network in addition to limiting use to few individuals.

Bibliography
------------

#. OpenStack Configuration Reference - Havana. SPICE Console. `SPICE Console
   <http://docs.openstack.org/havana/config-reference/content/spice-console.html>`__.
#. bugzilla.redhat.com, Bug 913607 - RFE: Support Tunnelling SPICE over
   websockets. 2013. `RedHat bug 913607 <https://bugzilla.redhat.com/show_bug.cgi?id=913607>`_.
