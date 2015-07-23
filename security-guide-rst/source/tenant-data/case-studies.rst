============
Case studies
============


Earlier in :doc:`../introduction/introduction-to-case-studies` we introduced
the Alice and Bob case studies where Alice is deploying a private government
cloud and Bob is deploying a public cloud each with different security
requirements. Here we dive into their particular tenant data privacy
requirements. Specifically, we will look into how Alice and Bob both handle
tenant data, data destruction, and data encryption.

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

As stated during the introduction to Alice's case study, data protection is of
an extremely high priority. She needs to ensure that a compromise of one
tenant's data does not cause loss of other tenant data. She also has strong
regulator requirements that require documentation of data destruction
activities. Alice does this using the following:

-  Establishing procedures to sanitize tenant data when a program or
   project ends.
-  Track the destruction of both the tenant data and metadata through
   ticketing in a CMDB.
-  For Volume storage:

   -  Physical server issues
   -  To provide secure ephemeral instance storage, Alice implements
      qcow2 files on an encrypted filesystem.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

As stated during the introduction to Bob's case study, tenant privacy is of an
extremely high priority. In addition to the requirements and actions Bob will
take to isolate tenants from one another at the infrastructure layer, Bob also
needs to provide assurances for tenant data privacy. Bob does this using the
following:

-  Establishing procedures to sanitize customer data when a customer
   churns.
-  Track the destruction of both the customer data and metadata through
   ticketing in a CMDB.
-  For Volume storage:

   -  Physical server issues
   -  To provide secure ephemeral instance storage, Bob implements qcow2
      files on an encrypted filesystems.
