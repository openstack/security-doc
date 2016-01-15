=========
Dashboard
=========

Horizon is the OpenStack dashboard that provides users a self-service portal to
provision their own resources within the limits set by administrators. These
include provisioning users, defining instance flavors, uploading VM images,
managing networks, setting up security groups, starting instances, and
accessing the instances through a console.

The dashboard is based on the Django web framework, therefore secure deployment
practices for Django apply directly to horizon. This guide provides a popular
set of Django security recommendations. Further information can be found by
reading the `Django documentation <https://docs.djangoproject.com/>`__.

The dashboard ships with reasonable default security settings, and has good
`deployment and configuration documentation
<http://docs.openstack.org/developer/horizon/topics/deployment.html>`__.

.. toctree::
   :maxdepth: 2

   dashboard/domains-dashboard-upgrades-basic-web-server-configuration.rst
   dashboard/https-hsts-xss-ssrf.rst
   dashboard/front-end-caching-session-back-end.rst
   dashboard/static-media.rst
   dashboard/passwords.rst
   dashboard/secret-key.rst
   dashboard/cookies.rst
   dashboard/cross-origin-resource-sharing-cors.rst
   dashboard/debug.rst
   dashboard/case-studies.rst
   dashboard/checklist.rst
