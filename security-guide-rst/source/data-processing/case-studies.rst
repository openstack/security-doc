============
Case studies
============

.. TODO (elmiko) fixup the introduction chapter link to point to case studies intro

Continuing with the studies described in :doc:`../introduction`, we
present Alice and Bob's approaches to deploying the Data
processing service for their users.

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

Alice is deploying the Data processing service for a group of users
that are trusted members of a collaboration. They are all placed in a
single project and share the clusters, jobs, and data within. She
deploys the controller with TLS enabled, using a certificate signed
by the organization's root certificate. She configures the controller
to provide floating IP addresses to the cluster instances allowing for
users to gain access to the instances in the event of errors. She
enables the use of proxy domains to prevent the users from needing to
enter their credentials into the Data processing service.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

Bob's public cloud contains users that will not necessarily
know or trust each other. He puts all users into separate projects.
Each user has their own clusters, jobs, and data which cannot be
accessed by other users. He deploys the controller with TLS enabled,
using a certificate signed by a well known public certificate
authority. He configures a custom topology to ensure that access to
the provisioned cluster instances will flow through a controlled
gateway. He creates a security group that opens only the ports needed
for the controller to access the frameworks deployed. He enables the
use of proxy domains to prevent the users from needing to enter their
credentials into the Data processing service. He configures the
rootwrap command to allow the data processing controller user to
run the proxy commands.
