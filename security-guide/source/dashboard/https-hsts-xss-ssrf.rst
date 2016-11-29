==========================
HTTPS, HSTS, XSS, and SSRF
==========================

Cross Site Scripting (XSS)
~~~~~~~~~~~~~~~~~~~~~~~~~~

Unlike many similar systems, the OpenStack dashboard allows the
entire Unicode character set in most fields. This means
developers have less latitude to make escaping mistakes that
open attack vectors for cross-site scripting (XSS).

Dashboard provides tools for developers to avoid creating
XSS vulnerabilities, but they only work if developers use them
correctly. Audit any custom dashboards, paying particular
attention to use of the ``mark_safe`` function,
use of ``is_safe`` with custom template tags, the ``safe``
template tag, anywhere auto escape is turned off, and any JavaScript
which might evaluate improperly escaped data.

Cross Site Request Forgery (CSRF)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Django has dedicated middleware for cross-site request forgery (CSRF).
For further details, see the
`Django documentation <https://docs.djangoproject.com/>`_.

The OpenStack dashboard is designed to discourage
developers from introducing cross-site scripting vulnerabilities
with custom dashboards as threads can be introduced. Dashboards
that utilize multiple instances of JavaScript should be audited
for vulnerabilities such as inappropriate use of the
``@csrf_exempt`` decorator. Any dashboard that
does not follow these recommended security settings should be
carefully evaluated before restrictions are relaxed.

Cross-Frame Scripting (XFS)
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Legacy browsers are still vulnerable to a Cross-Frame
Scripting (XFS) vulnerability, so the OpenStack dashboard
provides an option ``DISALLOW_IFRAME_EMBED`` that allows extra
security hardening where iframes are not used in deployment.

HTTPS
~~~~~

Deploy the dashboard behind a secure
:term:`HTTPS <Hypertext Transfer Protocol Secure (HTTPS)>` server by using a
valid, trusted certificate from a recognized certificate authority
(CA). Private organization-issued certificates are only
appropriate when the root of trust is pre-installed in all user
browsers.

Configure HTTP requests to the dashboard domain to redirect
to the fully qualified HTTPS URL.

HTTP Strict Transport Security (HSTS)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is highly recommended to use HTTP Strict Transport
Security (HSTS).

.. note::

   If you are using an HTTPS proxy in front of your web
   server, rather than using an HTTP server with HTTPS
   functionality, modify the ``SECURE_PROXY_SSL_HEADER``
   variable. Refer to the
   `Django documentation <https://docs.djangoproject.com/>`_
   for information about modifying the
   ``SECURE_PROXY_SSL_HEADER`` variable.

See the chapter on :doc:`../secure-communication` for more specific
recommendations and server configurations for HTTPS
configurations, including the configuration of HSTS.
