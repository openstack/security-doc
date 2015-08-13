=======
Cookies
=======

Session cookies should be set to HTTPONLY:

.. code:: python

    SESSION_COOKIE_HTTPONLY = True

Never configure CSRF or session cookies to have a wild card
domain with a leading dot. Horizon's session and CSRF cookie
should be secured when deployed with HTTPS:

.. code:: python

    CSRF_COOKIE_SECURE = True
    SESSION_COOKIE_SECURE = True
