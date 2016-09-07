=============================
TLS proxies and HTTP services
=============================

OpenStack endpoints are HTTP services providing APIs to both end-users on
public networks and to other OpenStack services on the management network.
It is highly recommended that all of these requests, both internal and
external, operate over TLS. To achieve this goal, API services must be
deployed behind a TLS proxy that can establish and terminate TLS sessions.
The following table offers a non-exhaustive list of open source software
that can be used for this purpose:

* `Pound <http://www.apsis.ch/pound>`_
* `Stud <https://github.com/bumptech/stud>`_
* `Nginx <http://nginx.org/>`_
* `Apache httpd <http://www.apache.org/>`_

In cases where software termination offers insufficient performance,
hardware accelerators may be worth exploring as an alternative option.
It is important to be mindful of the size of requests that will be
processed by any chosen TLS proxy.

Examples
~~~~~~~~

Below we provide sample recommended configuration settings for enabling
TLS in some of the more popular web servers/TLS terminators.

Before we delve into the configurations, we briefly discuss the ciphers'
configuration element and its format. A more exhaustive treatment on
available ciphers and the OpenSSL cipher list format can be found at:
`ciphers <https://www.openssl.org/docs/apps/ciphers.html>`_.

.. code:: ini

    ciphers = "HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM"

or

.. code:: ini

    ciphers = "kEECDH:kEDH:kRSA:HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM"

Cipher string options are separated by ":", while "!" provides negation
of the immediately following element. Element order indicates
preference unless overridden by qualifiers such as HIGH. Let us take a
closer look at the elements in the above sample strings.

``kEECDH:kEDH``
    Ephemeral Elliptic Curve Diffie-Hellman (abbreviated as EECDH and ECDHE).

    Ephemeral Diffie-Hellman (abbreviated either as EDH or DHE) uses prime
    field groups.

    Both approaches provide
    `Perfect Forward Secrecy (PFS) <https://en.wikipedia.org/wiki/Forward_secrecy>`_.
    See :ref:`secure-communication-perfect-forward-secrecy` for
    additional discussion on properly configuring PFS.

    Ephemeral Elliptic Curves require the server to be configured with
    a named curve, and provide better security than prime field groups
    and at lower computational cost. However, prime field groups are
    more widely implemented, and thus typically both are included in
    list.

``kRSA``
    Cipher suites using the
    `RSA <https://en.wikipedia.org/wiki/RSA_%28cryptosystem%29>`_
    exchange, authentication or either respectively.

``HIGH``
    Selects highest possible security cipher in the negotiation phase.
    These typically have keys of length 128 bits or longer.

``!RC4``
    No RC4. RC4 has flaws in the context of TLS V3. See
    `On the Security of RC4 in TLS and WPA <http://cr.yp.to/streamciphers/rc4biases-20130708.pdf>`_.

``!MD5``
    No MD5. MD5 is not collision resistant, and thus not acceptable for
    Message Authentication Codes (MAC) or signatures.

``!aNULL:!eNULL``
    Disallows clear text.

``!EXP``
    Disallows export encryption algorithms, which by design tend to be
    weak, typically using 40 and 56 bit keys.

    US Export restrictions on cryptography systems have been lifted and
    no longer need to be supported.

``!LOW:!MEDIUM``
    Disallows low (56 or 64 bit long keys) and medium (128 bit long
    keys) ciphers because of their vulnerability to brute force attacks
    (example 2-DES). This rule still permits Triple Data Encryption
    Standard (Triple DES) also known as Triple Data Encryption
    Algorithm (TDEA) and the Advanced Encryption Standard (AES), each
    of which has keys greater than equal to 128 bits and thus more
    secure.

``Protocols``
    Protocols are enabled/disabled through SSL_CTX_set_options. We
    recommend disabling SSLv2/v3 and enabling TLS.

Pound
-----

This Pound example enables ``AES-NI`` acceleration,
which helps to improve performance on systems with processors that
support this feature.
The default configuration file is ``/etc/pound/pound.cfg`` on Ubuntu,
``/etc/pound.cfg`` on RHEL, CentOS, openSUSE, and SUSE Linux Enterprise.

.. code::

    ## see pound(8) for details
    daemon      1
    ######################################################################
    ## global options:
    User        "swift"
    Group       "swift"
    #RootJail   "/chroot/pound"
    ## Logging: (goes to syslog by default)
    ##  0   no logging
    ##  1   normal
    ##  2   extended
    ##  3   Apache-style (common log format)
    LogLevel    0
    ## turn on dynamic scaling (off by default)
    # Dyn Scale 1
    ## check backend every X secs:
    Alive       30
    ## client timeout
    #Client     10
    ## allow 10 second proxy connect time
    ConnTO      10
    ## use hardware-acceleration card supported by openssl(1):
    SSLEngine   "aesni"
    # poundctl control socket
    Control "/var/run/pound/poundctl.socket"
    ######################################################################
    ## listen, redirect and ... to:
    ## redirect all swift requests on port 443 to local swift proxy
    ListenHTTPS
        Address 0.0.0.0
        Port    443
        Cert    "/etc/pound/cert.pem"
        ## Certs to accept from clients
        ##  CAlist      "CA_file"
        ## Certs to use for client verification
        ##  VerifyList  "Verify_file"
        ## Request client cert - don't verify
        ##  Ciphers     "AES256-SHA"
        ## allow PUT and DELETE also (by default only GET, POST and HEAD)?:
        NoHTTPS11   0
        ## allow PUT and DELETE also (by default only GET, POST and HEAD)?:
        xHTTP       1
        Service
            BackEnd
                Address 127.0.0.1
                Port    80
            End
        End
    End

Stud
----

The *ciphers* line can be tweaked based on your needs, however this is
a reasonable starting place.
The default configuration file is located in the ``/etc/stud`` directory.
However, it is not provided by default.

.. code::

    # SSL x509 certificate file.
    pem-file = "
    # SSL protocol.
    tls = on
    ssl = off
    # List of allowed SSL ciphers.
    # OpenSSL's high-strength ciphers which require authentication
    # NOTE: forbids clear text, use of RC4 or MD5 or LOW and MEDIUM strength ciphers
    ciphers = "HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM"
    # Enforce server cipher list order
    prefer-server-ciphers = on
    # Number of worker processes
    workers = 4
    # Listen backlog size
    backlog = 1000
    # TCP socket keepalive interval in seconds
    keepalive = 3600
    # Chroot directory
    chroot = ""
    # Set uid after binding a socket
    user = "www-data"
    # Set gid after binding a socket
    group = "www-data"
    # Quiet execution, report only error messages
    quiet = off
    # Use syslog for logging
    syslog = on
    # Syslog facility to use
    syslog-facility = "daemon"
    # Run as daemon
    daemon = off
    # Report client address using SENDPROXY protocol for haproxy
    # Disabling this until we upgrade to HAProxy 1.5
    write-proxy = off

Nginx
-----

This :term:`Nginx` example requires TLS v1.1 or v1.2 for maximum security. The
``ssl_ciphers`` line can be tweaked based on your needs, however this
is a reasonable starting place.
The default configuration file is ``/etc/nginx/nginx.conf``.

.. code::

    server {
        listen : ssl;
        ssl_certificate ;
        ssl_certificate_key ;
        ssl_protocols TLSv1.1 TLSv1.2;
        ssl_ciphers HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM
        ssl_session_tickets off;

        server_name _;
        keepalive_timeout 5;

        location / {

        }
    }

Apache
------

The default configuration file is ``/etc/apache2/apache2.conf`` on Ubuntu,
``/etc/httpd/conf/httpd.conf`` on RHEL and CentOS,
``/etc/apache2/httpd.conf`` on openSUSE and SUSE Linux Enterprise.

.. code::

    <VirtualHost <ip address>:80>
      ServerName <site FQDN>
      RedirectPermanent / https://<site FQDN>/
    </VirtualHost>
    <VirtualHost <ip address>:443>
      ServerName <site FQDN>
      SSLEngine On
      SSLProtocol +TLSv1 +TLSv1.1 +TLSv1.2,
      SSLCipherSuite HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM
      SSLCertificateFile    /path/<site FQDN>.crt
      SSLCACertificateFile  /path/<site FQDN>.crt
      SSLCertificateKeyFile /path/<site FQDN>.key
      WSGIScriptAlias / <WSGI script location>
      WSGIDaemonProcess horizon user=<user> group=<group> processes=3 threads=10
      Alias /static <static files location>
      <Directory <WSGI dir>>
        # For http server 2.2 and earlier:
        Order allow,deny
        Allow from all

        # Or, in Apache http server 2.4 and later:
        # Require all granted
      </Directory>
    </VirtualHost>

Compute API SSL endpoint in Apache, which you must pair with a short
WSGI script.

.. code::

    <VirtualHost <ip address>:8447>
      ServerName <site FQDN>
      SSLEngine On
      SSLProtocol +TLSv1 +TLSv1.1 +TLSv1.2
      SSLCipherSuite HIGH:!RC4:!MD5:!aNULL:!eNULL:!EXP:!LOW:!MEDIUM
      SSLCertificateFile    /path/<site FQDN>.crt
      SSLCACertificateFile  /path/<site FQDN>.crt
      SSLCertificateKeyFile /path/<site FQDN>.key
      SSLSessionTickets Off
      WSGIScriptAlias / <WSGI script location>
      WSGIDaemonProcess osapi user=<user> group=<group> processes=3 threads=10
      <Directory <WSGI dir>>
        # For http server 2.2 and earlier:
        Order allow,deny
        Allow from all

        # Or, in Apache http server 2.4 and later:
        # Require all granted
      </Directory>
    </VirtualHost>


HTTP strict transport security
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We recommend that all production deployments use HTTP strict transport
security (HSTS). This header prevents browsers from making insecure
connections after they have made a single secure one. If you have
deployed your HTTP services on a public or an untrusted domain, HSTS is
especially important. To enable HSTS, configure your web server to send
a header like this with all requests:

.. code::

    Strict-Transport-Security: max-age=31536000; includeSubDomains

Start with a short timeout of 1 day during testing, and raise it to one
year after testing has shown that you have not introduced problems for
users. Note that once this header is set to a large timeout, it is (by
design) very difficult to disable.

.. _secure-communication-perfect-forward-secrecy:

Perfect forward secrecy
~~~~~~~~~~~~~~~~~~~~~~~

Configuring TLS servers for perfect forward secrecy requires
careful planning around key size, session IDs, and session
tickets. In addition, for multi-server deployments, shared
state is also an important consideration. The example
configurations for Apache and :term:`Nginx` above disable the session
tickets options to help mitigate some of these concerns.
Real-world deployments may desire to enable this feature for
improved performance. This can be done securely, but would
require special consideration around key management. Such
configurations are beyond the scope of this guide. We suggest
reading
`How to botch TLS forward secrecy by ImperialViolet <https://www.imperialviolet.org/2013/06/27/botchingpfs.html>`_
as a starting place for understanding the problem space.
