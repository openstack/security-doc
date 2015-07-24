============
Case studies
============

Earlier in :doc:`../introduction/introduction-to-case-studies` we
introduced the Alice and Bob case studies where Alice is deploying a
private government cloud and Bob is deploying a public cloud each with
different security requirements. Here we discuss how Alice and
Bob would address monitoring and logging in the public vs a private
cloud. In both instances, time synchronization and a centralized store
of logs become extremely important for performing proper assessments and
troubleshooting of anomalies. Just collecting logs is not very useful, a
robust monitoring system must be built to generate actionable events.

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

As Alice is building out a new cloud within an existing organization,
she is able to leverage several existing tools inside the existing
business unit to help monitor and log her environment. She assigns a
resource to the Security Operations Center (SOC) to monitor and respond
to alerts coming from the new infrastructure. She uses a currently
existing Security Event and Incident Management (SEIM) solution, and
configures secure logging to the SEIM event collector. Alice and the SOC
analyst build the SEIM views so that logs are correlated by type, and
trigger alerts on unexpected or “interesting” events, such as a
successful login by a user immediately after a string of failed login
attempts within a given timeframe. The SOC analyst is also given
escalation protocols and contact information so that when an specific
event occurs, the analyst will escalate to the proper resource and
coordinate communications about the event.

Alice ensures that only her resource in the SOC has access to SEIM feeds
from her systems as well as the database back-end. She also gives the
services teams read-only access to separate views SEIM feeds so that
they can perform compliance-related duties such as regular log review or
create tickets for tracking and other engagement. Finally, based on the
default reporting that is currently built out, Alice may choose to hire
a consultant to ensure specific events are captured for compliance
purposes, or that specific events trigger the proper SEIM workflows.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

When it comes to logging, as a public cloud provider, Bob is interested
in the activities for situational awareness as well as compliance. In
the aspect of compliance, as a provider, Bob is subject to adherence to
various rules and regulations to include activities such as providing
timely, relevant logs or reports to customers to meet the requirements
of their compliance programs. With that in mind, Bob configures all of
his instances, nodes, and infrastructure devices to perform time
synchronization with an external, validated time device. Additionally,
Bob's team has built a Django based web application for his customers to
perform self-service log retrieval from the SIEM tool. Bob also uses
this SIEM tool along with a robust set of alerts and integration with
his CMDB to provide operational awareness to both customers and cloud
administrators.
