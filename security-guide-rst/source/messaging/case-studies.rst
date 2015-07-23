============
Case studies
============

Earlier in :doc:`../introduction/introduction-to-case-studies` we
introduced the Alice and Bob case studies where Alice is
deploying a private government cloud and Bob is deploying a public cloud
each with different security requirements. Here we discuss how Alice and
Bob would address security concerns around the messaging service.

The message queue is a critical piece of infrastructure that supports a
number of OpenStack services but is most strongly associated with the
Compute service. Due to the nature of the message queue service, Alice
and Bob have similar security concerns. One of the larger concerns that
remains is that many systems have access to this queue and there is no
way for a consumer of the queue messages to verify which host or service
placed the messages on the queue. An attacker who is able to
successfully place messages on the queue is able to create and delete VM
instances, attach the block storage of any tenant and a myriad of other
malicious actions. There are a number of solutions anticipated in the
near future, with several proposals for message signing and encryption
making their way through the OpenStack development process.

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

In this case, Alice's controls are the same as Bob's controls, which are
described below.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

Bob assumes the infrastructure or networks underpinning the Compute
service could become compromised, therefore he recognizes the importance
of hardening the system by restricting access to the message queue. In
order to accomplish this task Bob deploys his RabbitMQ servers with TLS
and X.509 client auth for access control. Hardening activities assists
in limiting the capabilities of a malicious user that has compromised
the system by disallowing queue access, provided that this user does not
have valid credentials to override the controls.

Additionally, Bob adds strong network ACL rulesets to enforce which
endpoints can communicate with the message servers. This second control
provides some additional assurance should the other protections fail.
