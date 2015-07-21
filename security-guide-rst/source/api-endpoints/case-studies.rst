============
Case studies
============

Earlier in :doc:`../introduction/introduction-to-case-studies` we introduced
the Alice and Bob case studies where Alice is deploying a private government
cloud and Bob is deploying a public cloud each with different security
requirements. Here we discuss how Alice and Bob would address endpoint
configuration to secure their private and public clouds. Alice's cloud is not
publicly accessible, but she is still concerned about securing the endpoints
against improper use. Bob's cloud, being public, must take measures to reduce
the risk of attacks by external adversaries.

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

Alice's organization requires that the security architecture protect the access
to the private endpoints, so she elects to use Apache with TLS enabled and
HAProxy for load balancing in front of the web service. As Alice's organization
has implemented its own certificate authority, she configures the services
within both the guest and management security domains to use these
certificates. Since Alice's OpenStack deployment exists entirely on a network
disconnected from the Internet, she makes sure to remove all default CA bundles
that contain external public CA providers to ensure the OpenStack services only
accept client certificates issued by her agency's CA. As she is using HAProxy,
Alice configures SSL offloading on her load balancer, and a virtual server IP
(VIP) on the load balancer with the http to https redirection policy to her API
endpoint systems.

Alice has registered all of the services in the Identity service's catalog,
using the internal URLs for access by internal services. She has installed
host-based intrusion detection (HIDS) to monitor the security events on the
endpoints. On the hosts, Alice also ensures that the API services are confined
to a network namespace while confirming that there is a robust SELinux profile
applied to the services.


Bob's public cloud
~~~~~~~~~~~~~~~~~~

Bob must also protect the access to the public and private endpoints, so he
elects to use the Apache TLS proxy on both public and internal services. On
the public services, he has configured the certificate key files with
certificates signed by a well-known Certificate Authority. He has used his
organization's self-signed CA to sign certificates in the internal services on
the Management network. Bob has registered his services in the Identity
service's catalog, using the internal URLs for access by internal services.
Bob's public cloud runs services on SELinux, which he has configured with a
mandatory access control policy to reduce the impact of any publicly accessible
services that may be compromised. He has also configured the endpoints with a
host-based IDS.
