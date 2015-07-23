============
Case studies
============

Earlier in :doc:`../introduction/introduction-to-case-studies` we
introduced the Alice and Bob case studies where Alice is deploying a
private government cloud and Bob is deploying a public cloud each
with different security requirements. Here we discuss how Alice and
Bob would address dashboard configuration to secure their private and
public clouds. Alice's dashboard is not publicly accessible, but she
is still concerned about securing the administrative dashboard
against improper use. Bob's dashboard, being public, must take
measures to reduce the risk of attacks by external adversaries.

Alice's cloud running a public application
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On the new installation, Alice deploys Apache as the Web
Service Gateway Interface (WSGI) so that she can take advantage of
the health monitoring and clustering features of HAProxy, and keep
a homogeneous deployment in her environment. She modifies the
``SECURE_PROXY_SSL_HEADER`` variable and disables
front end caching with with the session cookies set to httponly to
apply HSTS protections, which decreases the risk of communication
being downgraded from TLS to HTTP. Such a downgrade would be more
vulnerable to a 'man in the middle' (MITM) attack. As her
application is public facing, Alice creates an internal domain for
the dashboard access and issues internal PKI certificates.

Alice disables image uploading in the OpenStack dashboard
(horizon) as application users will not need this feature, and
management users will be uploading purpose-built images. As these
images will be sufficiently large, using the OpenStack Image
service (glance) upload features directly will be more efficient
than doing so through the dashboard, and her team has the required
access to the Image service. She uploads her divisions logo into
the dashboard page, but leaves the rest of the dashboard default
taking care not to add additional programs or features that may
introduce additional vulnerabilities.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

In this case Bob takes the same precautions Alice does, except
that Bob deploys his dashboard as public facing.
