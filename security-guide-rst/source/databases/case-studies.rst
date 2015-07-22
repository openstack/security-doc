============
Case studies
============

.. TODO (pdesai) fix link to introduction-to-case-studies

Earlier in :doc:`../introduction` we introduced the Alice and Bob case
studies where Alice is deploying a private government cloud and Bob is
deploying a public cloud each with different security requirements. Here
we discuss how Alice and Bob would address database selection and
configuration for their respective private and public clouds.

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

Alice's organization has high availability concerns and so she has
selected MySQL as the underlying database for the cloud services. She
places the database on the Management network, utilizing SSL/TLS with
mutual authentication among the services to ensure secure access. Based
on the assumption that external access of the database will not be
facilitated, she installs a certificate signed with the organization's
root certificate on the database and its access endpoints. Alice creates
separate user accounts for each database user then configures the
database to use both passwords and X.509 certificates for
authentication. She elects not to use the nova-conductor sub-service due
to the desire for fine-grained access control policies and audit
support.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

Bob is concerned about strong separation of his tenants' data, so he has
elected to use the PostgreSQL database, known for its stronger security
features. The database resides on the Management network and uses
SSL/TLS with mutual authentication with the services. Since the database
is on the Management network, the database uses certificates signed with
the company's self-signed root certificate. Bob creates separate user
accounts for each database user, and configures the database to use both
passwords and X.509 certificates for authentication. He elects not to
use the nova-conductor sub-service due to a desire for fine-grained
access control.
