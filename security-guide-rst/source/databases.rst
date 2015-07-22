=========
Databases
=========

The choice of database server is an important consideration in the
security of an OpenStack deployment. Multiple factors should be
considered when deciding on a database server, however for the scope of
this book only security considerations will be discussed. OpenStack
supports a variety of database types (see `OpenStack Cloud Administrator
Guide <http://docs.openstack.org/admin-guide-cloud>`__ for more
information). The Security Guide currently focuses on PostgreSQL and
MySQL.

.. toctree::
   :maxdepth: 2

   databases/database-backend-considerations.rst
   databases/database-access-control.rst
   databases/database-transport-security.rst
   databases/case-studies.rst
