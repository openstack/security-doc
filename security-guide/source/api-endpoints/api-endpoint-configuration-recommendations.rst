==========================================
API endpoint configuration recommendations
==========================================


Internal API communications
~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack provides both public facing and private API endpoints. By default,
OpenStack components use the publicly defined endpoints. The recommendation is
to configure these components to use the API endpoint within the proper
security domain.

Services select their respective API endpoints based on the OpenStack service
catalog. These services might not obey the listed public or internal API end
point values. This can lead to internal management traffic being routed to
external API endpoints.


Configure internal URLs in the Identity service catalog
-------------------------------------------------------

The Identity service catalog should be aware of your internal URLs. While this
feature is not utilized by default, it may be leveraged through configuration.
Additionally, it should be forward-compatible with expectant changes once this
behavior becomes the default.

To register an internal URL for an endpoint:

.. code:: console

   $ keystone endpoint-create \
     --region RegionOne \
     --service-id=1ff4ece13c3e48d8a6461faebd9cd38f \
     --publicurl='https://public-ip:8776/v1/%(tenant_id)s' \
     --internalurl='https://management-ip:8776/v1/%(tenant_id)s' \
     --adminurl='https://management-ip:8776/v1/%(tenant_id)s'


Configure applications for internal URLs
----------------------------------------

You can force some services to use specific API endpoints. Therefore, it
is recommended that each OpenStack service communicating to the API of
another service must be explicitly configured to access the proper
internal API endpoint.

Each project may present an inconsistent way of defining target API
endpoints. Future releases of OpenStack seek to resolve these
inconsistencies through consistent use of the Identity service catalog.


Configuration example #1: nova
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: ini

    cinder_catalog_info='volume:cinder:internalURL'
    glance_protocol='https'
    neutron_url='https://neutron-host:9696'
    neutron_admin_auth_url='https://neutron-host:9696'
    s3_host='s3-host'
    s3_use_ssl=True


Configuration example #2: cinder
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: ini

   glance_host = 'https://glance-server'


Paste and middleware
~~~~~~~~~~~~~~~~~~~~

Most API endpoints and other HTTP services in OpenStack use the Python Paste
Deploy library. From a security perspective, this library enables manipulation
of the request filter pipeline through the application's configuration. Each
element in this chain is referred to as *middleware*. Changing the order of
filters in the pipeline or adding additional middleware might have
unpredictable security impact.

Commonly, implementers add middleware to extend OpenStack's base functionality.
We recommend implementers make careful consideration of the potential exposure
introduced by the addition of non-standard software components to their HTTP
request pipeline.

For more information about Paste Deploy, see
`Python Paste Deployment documentation <http://pythonpaste.org/deploy/>`__.


API endpoint process isolation and policy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should isolate API endpoint processes, especially those that reside within
the public security domain should be isolated as much as possible. Where
deployments allow, API endpoints should be deployed on separate hosts for
increased isolation.


Namespaces
----------

Many operating systems now provide compartmentalization support. Linux supports
namespaces to assign processes into independent domains. Other parts of this
guide cover system compartmentalization in more detail.


Network policy
--------------

Because API endpoints typically bridge multiple security domains, you must pay
particular attention to the compartmentalization of the API processes. See
:ref:`Bridging_security_domains` for additional information in this area.

With careful modeling, you can use network ACLs and IDS technologies to enforce
explicit point to point communication between network services. As a critical
cross domain service, this type of explicit enforcement works well for
OpenStack's message queue service.

To enforce policies, you can configure services, host-based firewalls (such as
iptables), local policy (SELinux or AppArmor), and optionally global network
policy.


Mandatory access controls
-------------------------

You should isolate API endpoint processes from each other and other processes
on a machine. The configuration for those processes should be restricted to
those processes not only by Discretionary Access Controls, but through
Mandatory Access Controls. The goal of these enhanced access controls is to
aid in the containment and escalation of API endpoint security breaches. With
mandatory access controls, such breaches severely limit access to resources and
provide earlier alerting on such events.
