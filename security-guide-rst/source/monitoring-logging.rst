======================
Monitoring and logging
======================

A lot of activity goes on within a cloud environment. It is a mix of hardware,
operating systems, virtual machine managers, the OpenStack services, cloud-user
activity such as creating instances and attaching storage, the network
underlying the whole, and finally end-users using the applications running on
the various instances.

The basics of logging: configuration, setting log level, location of the log
files, and how to use and customize logs, as well as how to do centralized
collections of logs is well covered in the `OpenStack Operations Guide
<http://docs.openstack.org/ops/>`__.

.. toctree::
   :maxdepth: 2

   monitoring-logging/forensics-and-incident-response.rst
   monitoring-logging/case-studies.rst
