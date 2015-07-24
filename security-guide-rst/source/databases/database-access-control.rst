=======================
Database access control
=======================

Each of the core OpenStack services (Compute, Identity, Networking,
Block Storage) store state and configuration information in databases.
In this chapter, we discuss how databases are used currently in
OpenStack. We also explore security concerns, and the security
ramifications of database back end choices.

OpenStack database access model
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All of the services within an OpenStack project access a single
database. There are presently no reference policies for creating table
or row based access restrictions to the database.

There are no general provisions for granular control of database
operations in OpenStack. Access and privileges are granted simply based
on whether a node has access to the database or not. In this scenario,
nodes with access to the database may have full privileges to DROP,
INSERT, or UPDATE functions.

Granular access control
-----------------------

By default, each of the OpenStack services and their processes access
the database using a shared set of credentials. This makes auditing
database operations and revoking access privileges from a service and
its processes to the database particularly difficult.

.. image:: ../figures/databaseusername.png

Nova-conductor
--------------

The compute nodes are the least trusted of the services in OpenStack
because they host tenant instances. The nova-conductor service has been
introduced to serve as a database proxy, acting as an intermediary
between the compute nodes and the database. We discuss its ramifications
later in this chapter.

We strongly recommend:

-  All database communications be isolated to a management network

-  Securing communications using TLS

-  Creating unique database user accounts per OpenStack service endpoint
   (illustrated below)

.. image:: ../figures/databaseusernamessl.png

.. _database-authentication-and-access-control:

Database authentication and access control
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Given the risks around access to the database, we strongly recommend
that unique database user accounts be created per node needing access to
the database. Doing this facilitates better analysis and auditing for
ensuring compliance or in the event of a compromise of a node allows you
to isolate the compromised host by removing access for that node to the
database upon detection. When creating these per service endpoint
database user accounts, care should be taken to ensure that they are
configured to require TLS. Alternatively, for increased security it is
recommended that the database accounts be configured using X.509
certificate authentication in addition to user names and passwords.

Privileges
----------

A separate database administrator (DBA) account should be created and
protected that has full privileges to create/drop databases, create user
accounts, and update user privileges. This simple means of separation of
responsibility helps prevent accidental misconfiguration, lowers risk
and lowers scope of compromise.

The database user accounts created for the OpenStack services and for
each node should have privileges limited to just the database relevant
to the service where the node is a member.

Require user accounts to require SSL transport
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration example #1: (MySQL)
---------------------------------

::

    GRANT ALL ON dbname.* to 'compute01'@'hostname' IDENTIFIED BY 'NOVA_DBPASS' REQUIRE SSL;

Configuration example #2: (PostgreSQL)
--------------------------------------

In file :file:`pg_hba.conf`:

::

    hostssl dbname compute01 hostname md5

Note this command only adds the ability to communicate over SSL and is
non-exclusive. Other access methods that may allow unencrypted transport
should be disabled so that SSL is the sole access method.

The ``md5`` parameter defines the authentication method as a hashed
password. We provide a secure authentication example in the section
below.

OpenStack service database configuration
----------------------------------------

If your database server is configured for TLS transport, you will need
to specify the certificate authority information for use with the
initial connection string in the SQLAlchemy query.

Example of a ``:sql_connection`` string to MySQL:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: ini

    sql_connection = mysql://compute01:NOVA_DBPASS@localhost/nova?charset=utf8&ssl_ca=/etc/mysql/cacert.pem

Authentication with X.509 certificates
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Security may be enhanced by requiring X.509 client certificates for
authentication. Authenticating to the database in this manner provides
greater identity assurance of the client making the connection to the
database and ensures that the communications are encrypted.

Configuration example #1: (MySQL)
---------------------------------

::

    GRANT ALL on dbname.* to 'compute01'@'hostname' IDENTIFIED BY 'NOVA_DBPASS' REQUIRE SUBJECT
    '/C=XX/ST=YYY/L=ZZZZ/O=cloudycloud/CN=compute01' AND ISSUER
    '/C=XX/ST=YYY/L=ZZZZ/O=cloudycloud/CN=cloud-ca';

Configuration example #2: (PostgreSQL)
--------------------------------------

::

    hostssl dbname compute01 hostname cert

OpenStack service database configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If your database server is configured to require X.509 certificates for
authentication you will need to specify the appropriate SQLAlchemy query
parameters for the database back end. These parameters specify the
certificate, private key, and certificate authority information for use
with the initial connection string.

Example of a ``:sql_connection`` string for X.509 certificate
authentication to MySQL:

.. code:: ini

    sql_connection = mysql://compute01:NOVA_DBPASS@localhost/nova?
    charset=utf8&ssl_ca = /etc/mysql/cacert.pem&ssl_cert=/etc/mysql/server-cert.pem&ssl_key=/etc/mysql/server-key.pem

Nova-conductor
~~~~~~~~~~~~~~

OpenStack Compute offers a sub-service called nova-conductor which
proxies database connections, with the primary purpose of having the
nova compute nodes interfacing with nova-conductor to meet data
persistence needs as opposed to directly communicating with the
database.

Nova-conductor receives requests over RPC and performs actions on behalf
of the calling service without granting granular access to the database,
its tables, or data within. Nova-conductor essentially abstracts direct
database access away from compute nodes.

This abstraction offers the advantage of restricting services to
executing methods with parameters, similar to stored procedures,
preventing a large number of systems from directly accessing or
modifying database data. This is accomplished without having these
procedures stored or executed within the context or scope of the
database itself, a frequent criticism of typical stored procedures.

.. image:: ../figures/novaconductor.png

Unfortunately, this solution complicates the task of more fine-grained
access control and the ability to audit data access. Because the
nova-conductor service receives requests over RPC, it highlights the
importance of improving the security of messaging. Any node with access
to the message queue may execute these methods provided by the
nova-conductor and effectively modifying the database.

Note, as nova-conductor only applies to OpenStack Compute, direct
database access from compute hosts may still be necessary for the
operation of other OpenStack components such as Telemetry (ceilometer),
Networking, and Block Storage.

To disable the nova-conductor, place the following into your
:file:`nova.conf` file (on your compute hosts):

.. code:: ini

    [conductor]
    use_local = true
