============
Static media
============

The dashboard's static media should be deployed to a subdomain
of the dashboard domain and served by the web server. The use of
an external content delivery network (CDN) is also acceptable.
This subdomain should not set cookies or serve user-provided
content. The media should also be served with HTTPS.

Django media settings are documented in the
`Django documentation <https://docs.djangoproject.com/>`_.

Dashboard's default configuration uses
`django_compressor <http://django-compressor.readthedocs.org/>`_
to compress and minify CSS and
JavaScript content before serving it. This process should be
statically done before deploying the dashboard, rather than using
the default in-request dynamic compression and copying the
resulting files along with deployed code or to the CDN server.
Compression should be done in a non-production build
environment. If this is not practical, we recommend disabling
resource compression entirely. Online compression dependencies
(less, Node.js) should not be installed on production
machines.
