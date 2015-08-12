===============================
Forensics and incident response
===============================

The generation and collection of logs is an important component of
securely monitoring an OpenStack infrastructure. Logs provide visibility
into the day-to-day actions of administrators, tenants, and guests, in
addition to the activity in the compute, networking, and storage and
other components that comprise your OpenStack deployment.

Logs are not only valuable for proactive security and continuous
compliance activities, but they are also a valuable information source
for investigating and responding to incidents.

For instance, analyzing the access logs of Identity service or its
replacement authentication system would alert us to failed logins,
frequency, origin IP, whether the events are restricted to select
accounts and other pertinent information. Log analysis supports
detection.

Actions may be taken to mitigate potential malicious activity such as
blacklisting an IP address, recommending the strengthening of user
passwords, or de-activating a user account if it is deemed dormant.

Monitoring use cases
~~~~~~~~~~~~~~~~~~~~

Event monitoring is a more pro-active approach to securing an
environment, providing real-time detection and response. Several tools
exist which can aid in monitoring.

In the case of an OpenStack cloud instance, we need to monitor the
hardware, the OpenStack services, and the cloud resource usage. The
latter stems from wanting to be elastic, to scale to the dynamic needs
of the users.

Here are a few important use cases to consider when implementing log
aggregation, analysis and monitoring. These use cases can be implemented
and monitored through various applications, tools or scripts. There are
open source and commercial solutions and some operators develop their
own in-house solutions. These tools and scripts can generate events that
can be sent to administrators through email or viewed in the integrated
dashboard. It is important to consider additional use cases that may
apply to your specific network and what you may consider anomalous
behavior.

-  Detecting the absence of log generation is an event of high value.
   Such an event would indicate a service failure or even an intruder
   who has temporarily switched off logging or modified the log level to
   hide their tracks.

-  Application events such as start or stop events that were unscheduled
   would also be events to monitor and examine for possible security
   implications.

-  Operating system events on the OpenStack service machines such as
   user logins or restarts also provide valuable insight into proper and
   improper usage of systems.

-  Being able to detect the load on the OpenStack servers also enables
   responding by way of introducing additional servers for load
   balancing to ensure high availability.

-  Other events that are actionable are networking bridges going down,
   ip tables being flushed on compute nodes and consequential loss of
   access to instances resulting in unhappy customers.

-  To reduce security risks from orphan instances on a user, tenant, or
   domain deletion in the Identity service there is discussion to
   generate notifications in the system and have OpenStack components
   respond to these events as appropriate such as terminating instances,
   disconnecting attached volumes, reclaiming CPU and storage resources
   and so on.

A cloud will host many virtual instances, and monitoring these instances
goes beyond hardware monitoring and log files which may just contain
CRUD events.

Security monitoring controls such as intrusion detection software,
antivirus software, and spyware detection and removal utilities can
generate logs that show when and how an attack or intrusion took place.
Deploying these tools on the cloud machines provides value and
protection. Cloud users, those running instances on the cloud, may also
want to run such tools on their instances.

Bibliography
~~~~~~~~~~~~

Siwczak, Piotr. Some Practical Considerations for Monitoring in the
OpenStack Cloud. 2012.
`http://www.mirantis.com/blog/openstack-monitoring <http://www.mirantis.com/blog/openstack-monitoring/>`__

blog.sflow.com, sflow: Host sFlow distributed agent. 2012.
http://blog.sflow.com/2012/01/host-sflow-distributed-agent.html

blog.sflow.com, sflow: LAN and WAN. 2009.
http://blog.sflow.com/2009/09/lan-and-wan.html

blog.sflow.com, sflow: Rapidly detecting large flows sFlow vs.
NetFlow/IPFIX. 2013.
http://blog.sflow.com/2013/01/rapidly-detecting-large-flows-sflow-vs.html
