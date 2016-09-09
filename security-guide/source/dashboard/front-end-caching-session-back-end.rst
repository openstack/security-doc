======================================
Front-end caching and session back end
======================================

Front-end caching
~~~~~~~~~~~~~~~~~

We do not recommend using front-end caching tools with the
dashboard. The dashboard is rendering dynamic content resulting
directly from OpenStack API requests and front-end caching layers
such as varnish can prevent the correct content from being
displayed. In Django, static media is directly served from Apache
or :term:`Nginx` and already benefits from web host caching.

Session back end
~~~~~~~~~~~~~~~~

The default session back end for horizon
(``django.contrib.sessions.backends.signed_cookies``)
saves user data in signed, but unencrypted cookies stored in the
browser. Due to the fact that each dashboard instance is
stateless, the previously mentioned methodology provides the
ability to implement the most simple session back-end scaling.

It should be noted that with this type of implementation
sensitive access tokens will be stored in the browser and will be
transmitted with each request made. The back end ensures the
integrity of session data, even though the transmitted data
is only encrypted by HTTPS.

If your architecture allows it, we recommend using
``django.contrib.sessions.backends.cache`` as
your session back end with memcache as the cache. Memcache must
not be exposed publicly, and should communicate over a secured
private channel. If you choose to use the signed cookies
back end, refer to the Django documentation to understand the
security trade-offs.

For further details, see the
`Django documentation <https://docs.djangoproject.com/>`_.
