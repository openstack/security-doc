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
``django.contrib.sessions.backends.signed_cookies``
saves user data in signed, but unencrypted cookies stored in the
browser. Due to the fact that each dashboard instance is
stateless, the previously mentioned methodology provides the
ability to implement the most simple session back-end scaling.

It should be noted that with this type of implementation
sensitive access tokens will be stored in the browser and will be
transmitted with each request made. The back end ensures the
integrity of session data, even though the transmitted data
is only encrypted by HTTPS.

If your architecture allows for shared storage and and if you
have configured your cache correctly, we recommend setting your
``SESSION_ENGINE`` to ``django.contrib.sessions.backends.cache``
and using it as cache-based session backend with memcached as
the cache. Memcached is an efficient in-memory key-value store
for chunks of data that can be used in a high availability and
distributed environment and is easy to configure. However, you
need to ensure that there is no data leakage. Memcached makes use
of spare RAM to store frequently accessed data blocks, acting
like memory cache for repeatedly accessed information. Since
memcached utilizes local memory, there is no overhead of
database and file system usage leading to direct access of data
from RAM rather than from disk.

We recommend the use of memcached instead of local-memory cache
because it is fast, retains data for a longer duration, is
multi-process safe and has the ability to share cache over
multiple servers, but still treats it as a single cache.

To enable memcached, execute the following:

.. code-block:: ini

    SESSION_ENGINE = 'django.contrib.sessions.backends.cache'
    CACHES = {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache'
    }

For further details, see the
`Django documentation <https://docs.djangoproject.com/>`_.
