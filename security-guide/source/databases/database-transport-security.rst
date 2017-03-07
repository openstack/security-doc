===========================
Database transport security
===========================

This chapter covers issues related to network communications to and from
the database server. This includes IP address bindings and encrypting
network traffic with TLS.

Database server IP address binding
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To isolate sensitive database communications between the services and
the database, we strongly recommend that the database server(s) be
configured to only allow communications to and from the database over an
isolated management network. This is achieved by restricting the
interface or IP address on which the database server binds a network
socket for incoming client connections.

Restricting bind address for MySQL
----------------------------------

In ``my.cnf``:

.. code:: ini

    [mysqld]
    ...
    bind-address <ip address or hostname of management network interface>

Restricting listen address for PostgreSQL
-----------------------------------------

In ``postgresql.conf``:

.. code:: ini

    listen_addresses = <ip address or hostname of management network interface>

Database transport
~~~~~~~~~~~~~~~~~~

In addition to restricting database communications to the management
network, we also strongly recommend that the cloud administrator
configure their database back end to require TLS. Using TLS for the
database client connections protects the communications from tampering
and eavesdropping. As will be discussed in the next section, using TLS
also provides the framework for doing database user authentication
through X.509 certificates (commonly referred to as PKI). Below is
guidance on how TLS is typically configured for the two popular database
back ends MySQL and PostgreSQL.

.. Note::

    When installing the certificate and key files, ensure that the file
    permissions are restricted, for example ``chmod 0600``, and the
    ownership is restricted to the database daemon user to prevent
    unauthorized access by other processes and users on the database
    server.

MySQL SSL configuration
~~~~~~~~~~~~~~~~~~~~~~~

The following lines should be added in the system-wide MySQL
configuration file:

In ``my.cnf``:

.. code:: ini

    [[mysqld]]
    ...
    ssl-ca = /path/to/ssl/cacert.pem
    ssl-cert = /path/to/ssl/server-cert.pem
    ssl-key = /path/to/ssl/server-key.pem

Optionally, if you wish to restrict the set of SSL ciphers used for the
encrypted connection. See `ciphers
<https://www.openssl.org/docs/manmaster/man1/ciphers.html>`_
for a list of ciphers and the syntax for specifying the cipher string:

.. code:: ini

    ssl-cipher = 'cipher:list'

PostgreSQL SSL configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following lines should be added in the system-wide PostgreSQL
configuration file, ``postgresql.conf``.

.. code:: ini

    ssl = true

Optionally, if you wish to restrict the set of SSL ciphers used for the
encrypted connection. See `ciphers
<https://www.openssl.org/docs/manmaster/man1/ciphers.html>`_
for a list of ciphers and the syntax for specifying the cipher string:

.. code:: ini

    ssl-ciphers = 'cipher:list'

The server certificate, key, and certificate authority (CA) files should
be placed in the $PGDATA directory in the following files:

-  ``$PGDATA/server.crt`` - Server certificate

-  ``$PGDATA/server.key`` - Private key corresponding to ``server.crt``

-  ``$PGDATA/root.crt`` - Trusted certificate authorities

-  ``$PGDATA/root.crl`` - Certificate revocation list
