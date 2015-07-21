===============
Data processing
===============

The Data processing service for OpenStack (sahara) provides a platform
for the provisioning and management of instance clusters using processing
frameworks such as Hadoop and Spark. Through the OpenStack dashboard
or REST API, users will be able to upload and execute framework
applications which may access data in object storage or external
providers. The data processing controller uses the Orchestration
service to create clusters of instances which may exist as
long-running groups that can grow and shrink as requested, or as
transient groups created for a single workload.

.. toctree::
   :maxdepth: 2

   data-processing/introduction-to-data-processing.rst
   data-processing/deployment.rst
   data-processing/configuration-and-hardening.rst
   data-processing/case-studies.rst
