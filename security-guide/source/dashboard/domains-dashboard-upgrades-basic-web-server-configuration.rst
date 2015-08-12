====================================================================
Domain names, dashboard upgrades, and basic web server configuration
====================================================================

Domain names
~~~~~~~~~~~~

Many organizations typically deploy web applications at
subdomains of an overarching organization domain. It is natural
for users to expect a domain of the form
``openstack.example.org``. In this context, there are
often applications which are deployed in the same second-level
namespace. This name structure is convenient and simplifies name
server maintenance.

We strongly recommend deploying dashboard to a
*second-level domain*, such as
``https://example.com``, rather than deploying
dashboard on a *shared subdomain* of any level,
for example ``https://openstack.example.org`` or
``https://horizon.openstack.example.org``. We also
advise against deploying to bare internal domains like
``https://horizon/``. These recommendations are based on the
limitations of browser same-origin-policy.

Recommendations given in this guide cannot effectively guard against
known attacks if you deploy the dashboard in a domain that also hosts
user-generated content, even when this content resides on a separate
sub-domain. User-generated content can consist of scripts, images, or uploads
of any type. Most major web presences, including googleusercontent.com,
fbcdn.com, github.io, and twimg.co, use this approach to segregate
user-generated content from cookies and security tokens.

If you do not follow this recommendation regarding
second-level domains, avoid a cookie-backed session store and
employ HTTP Strict Transport Security (HSTS). When deployed on
a subdomain, the dashboard's security is equivalent to the least secure
application deployed on the same second-level domain.

Basic web server configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The dashboard should be deployed as a Web Services Gateway
Interface (WSGI) application behind an HTTPS proxy such as
Apache or nginx. If Apache is not already in use, we recommend
nginx since it is lightweight and easier to configure
correctly.

When using nginx, we recommend
`gunicorn <http://docs.gunicorn.org/en/latest/deploy.html>`_
as the WSGI host with an appropriate number
of synchronous workers. When using Apache, we recommend
``mod_wsgi`` to host the dashboard.

Allowed hosts
~~~~~~~~~~~~~

Configure the ``ALLOWED_HOSTS`` setting with
the domain or domains where the dashboard is available. Failure
to configure this setting (especially if not following the
recommendation above regarding second level domains) opens the
dashboard to a number of serious attacks. Wild card domains
should be avoided.

For further details, see the
`Django documentation <https://docs.djangoproject.com/>`_.

Horizon image upload
~~~~~~~~~~~~~~~~~~~~

We recommend that implementers
`disable HORIZON_IMAGES_ALLOW_UPLOAD <http://docs.openstack.org/developer/horizon/topics/deployment.html#file-uploads>`_
unless they have implemented a plan to prevent resource
exhaustion and denial of service.

