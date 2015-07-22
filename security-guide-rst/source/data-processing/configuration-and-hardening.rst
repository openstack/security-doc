===========================
Configuration and hardening
===========================

There are several configuration options and deployment strategies that
can improve security in the Data processing service. The service
controller is configured through a main configuration file and one or
more policy files. Installations that are using the data-locality
features will also have two additional files to specify the physical
location of Compute and Object Storage nodes.

TLS
~~~

The Data processing service controller, like many other OpenStack
controllers, can be configured to require TLS connections.

.. TODO (elmiko) fixup secure communication chapter link to point to tls
   proxies section

Pre-Kilo releases will require a TLS proxy as the controller does not
allow direct TLS connections. Configuring TLS proxies is
covered in :doc:`../secure-communication`, and we recommend following the
advice there to create this type of installation.

From the Kilo release onward the data processing controller allows
direct TLS connections. Enabling this behavior requires some small
adjustments to the controller configuration file. For any post-Juno
installation we recommend enabling the direct TLS connections in
the controller configuration.

**Example. Configuring TLS access to the controller**

.. code-block:: ini

    [ssl]
    ca_file = cafile.pem
    cert_file = certfile.crt
    key_file = keyfile.key

.. _data-processing-rbac-policies:

Role-based access control policies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. TODO (elmiko) fixup identity chapter link to point to policy section

The Data processing service uses a policy file, as described in
:doc:`../identity`, to configure role-based access control. Using the
policy file an operator can restrict a group’s access to specific
data processing functionality.

The reasons for doing this will change depending on the organizational
requirements of the installation. In general, these fine
grained controls are used in situations where an operator needs to
restrict the creation, deletion, and retrieval of the Data processing
service resources. Operators who need to restrict access within a project
should be fully aware that there will need to be alternative means for
users to gain access to the core functionality of the service (for
example, provisioning clusters).

**Example. Allow all methods to all users (default policy)**

.. code-block:: json

      {
          "default": ""
      }

**Example. Disallow image registry manipulations to non-admin users**

.. code-block:: json

      {
          "default": "",

          "data-processing:images:register": "role:admin",
          "data-processing:images:unregister": "role:admin",
          "data-processing:images:add_tags": "role:admin",
          "data-processing:images:remove_tags": "role:admin"
      }

Security groups
~~~~~~~~~~~~~~~

The Data processing service allows for the association of security
groups with instances provisioned for its clusters. With no additional
configuration the service will use the default security group for any
project that provisions clusters. A different security group may be
used if requested, or an automated option exists which instructs the
service to create a security group based on ports specified by the
framework being accessed.

.. TODO (elmiko) fixup networking chapter link to point to security groups
   section

For production environments we recommend controlling the security
groups manually and creating a set of group rules that are appropriate
for the installation. In this manner the operator can ensure that the
default security group will contain all the appropriate rules. For an
expanded discussion of security groups please see :doc:`../networking`.

.. _data-processing-proxy-domains:

Proxy domains
~~~~~~~~~~~~~

When using the Object Storage service in conjunction with data
processing it is necessary to add credentials for the store access.
With proxy domains the Data processing service can instead use a
delegated trust from the Identity service to allow store access via a
temporary user created in the domain. For this delegation mechanism to
work the Data processing service must be configured to use proxy
domains and the operator must configure an identity domain for the
proxy users.

The data processing controller retains temporary storage of the
username and password provided for object store access. When using proxy
domains the controller will generate this pair for the proxy user, and
the access of this user will be limited to that of the identity trust.
We recommend using proxy domains in any installation where the
controller or its database have routes to or from public networks.

**Example. Configuring for a proxy domain named “dp_proxy”**

.. code-block:: ini

    [DEFAULT]
    use_domain_for_proxy_users = true
    proxy_user_domain_name = dp_proxy
    proxy_user_role_names = Member

Custom network topologies
~~~~~~~~~~~~~~~~~~~~~~~~~

The data processing controller can be configured to use proxy commands
for accessing its cluster instances. In this manner custom network
topologies can be created for installations which will not use the
networks provided directly by the Networking service. We recommend
using this option for installations which require limiting access
between the controller and the instances.

**Example. Access instances through a specified relay machine**

.. code-block:: ini

    [DEFAULT]
    proxy_command='ssh relay-machine-{tenant_id} nc {host} {port}'

**Example. Access instances through a custom network namespace**

.. code-block:: ini

    [DEFAULT]
    proxy_command='ip netns exec ns_for_{network_id} nc {host} {port}'

Indirect access
~~~~~~~~~~~~~~~

For installations in which the controller will have limited access to
all the instances of a cluster, due to limits on floating IP addresses
or security rules, indirect access may be configured. This allows some
instances to be designated as proxy gateways to the other instances of
the cluster.

This configuration can only be enabled while defining the node group
templates that will make up the data processing clusters. It is
provided as a run time option to be enabled during the cluster
provisioning process.

Rootwrap
~~~~~~~~

When creating custom topologies for network access it can be necessary
to allow non-root users the ability to run the proxy commands. For
these situations the oslo rootwrap package is used to provide a
facility for non-root users to run privileged commands. This
configuration requires the user associated with the data processing
controller application to be in the sudoers list and for the option to
be enabled in the configuration file. Optionally, an alternative
rootwrap command can be provided.

**Example. Enabling rootwrap usage and showing the default command**

.. code-block:: ini

    [DEFAULT]
    use_rootwrap=True
    rootwrap_command=’sudo sahara-rootwrap /etc/sahara/rootwrap.conf’

For more information on the rootwrap project, please see the official
documentation:
`https://wiki.openstack.org/wiki/Rootwrap <https://wiki.openstack.org/wiki/Rootwrap>`_

Logging
~~~~~~~

Monitoring the output of the service controller is a powerful forensic
tool, as described more thoroughly in :doc:`../monitoring-logging`.
The Data processing service controller offers a few options for setting
the location and level of logging.

**Example. Setting the log level higher than warning and specifying
an output file.**

.. code-block:: ini

    [DEFAULT]
    verbose = true
    log_file = /var/log/data-processing.log

References
~~~~~~~~~~

Sahara project documentation:
`http://docs.openstack.org/developer/sahara <http://docs.openstack.org/developer/sahara>`_

Hadoop project:
`https://hadoop.apache.org <https://hadoop.apache.org>`_

Hadoop secure mode docs:
`https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SecureMode.html <https://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SecureMode.html>`_

Hadoop HDFS documentation:
`https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/HdfsUserGuide.html <https://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/HdfsUserGuide.html>`_

Spark project:
`https://spark.apache.org <https://spark.apache.org>`_

Spark security documentation:
`https://spark.apache.org/docs/latest/security.html <https://spark.apache.org/docs/latest/security.html>`_

Storm project:
`https://storm.apache.org <https://storm.apache.org>`_

Zookeeper project:
`https://zookeeper.apache.org <https://zookeeper.apache.org>`_

Oozie project:
`https://oozie.apache.org <https://oozie.apache.org>`_

Hive
`https://hive.apache.org <https://hive.apache.org>`_

Pig
`https://pig.apache.org <https://pig.apache.org>`_

Cloudera CDH documentation:
`https://www.cloudera.com/content/cloudera/en/documentation.html#CDH <https://www.cloudera.com/content/cloudera/en/documentation.html#CDH>`_

Hortonworks Data Platform documentation:
`http://docs.hortonworks.com <http://docs.hortonworks.com>`_

MapR project:
`https://www.mapr.com/products/mapr-distribution-including-apache-hadoop <https://www.mapr.com/products/mapr-distribution-including-apache-hadoop>`_
