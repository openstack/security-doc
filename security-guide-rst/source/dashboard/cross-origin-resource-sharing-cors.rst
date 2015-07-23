====================================
Cross Origin Resource Sharing (CORS)
====================================

Configure your web server to send a restrictive CORS header
with each response, allowing only the dashboard domain and
protocol:

.. code::

    Access-Control-Allow-Origin: https://example.com/

Never allow the wild card origin.
