=========
Checklist
=========

Check-Identity-01: Is user/group ownership of config files set to keystone?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration files contain critical parameters and information required
for smooth functioning of the component. If an unprivileged user, either
intentionally or accidently modifies or deletes any of the parameters or
the file itself then it would cause severe availability issue causing
denial of service to the other end users. Thus user and group ownership
of such critical configuration files must be set to that component
owner.

Run the following commands:

.. code:: console

    $ stat -L -c "%U %G" /etc/keystone/keystone.conf | egrep "keystone keystone"
    $ stat -L -c "%U %G" /etc/keystone/keystone-paste.ini | egrep "keystone keystone"
    $ stat -L -c "%U %G" /etc/keystone/policy.json | egrep "keystone keystone"
    $ stat -L -c "%U %G" /etc/keystone/logging.conf | egrep "keystone keystone"
    $ stat -L -c "%U %G" /etc/keystone/ssl/certs/signing_cert.pem | egrep "keystone keystone"
    $ stat -L -c "%U %G" /etc/keystone/ssl/private/signing_key.pem | egrep "keystone keystone"
    $ stat -L -c "%U %G" /etc/keystone/ssl/certs/ca.pem | egrep "keystone keystone"

**Pass:** If user and group ownership of all these config files is set
to keystone. The above commands show output of keystone keystone.

**Fail:** If the above commands does not return any output as the user
or group ownership might have set to any user other than keystone.

Recommended in: :ref:`internally-implemented-authentication-methods`.

Check-Identity-02: Are strict permissions set for Identity configuration files?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to previous check, it is recommended to set strict access
permissions for such configuration files.

Run the following commands:

.. code:: console

    $ stat -L -c "%a" /etc/keystone/keystone.conf
    $ stat -L -c "%a" /etc/keystone/keystone-paste.ini
    $ stat -L -c "%a" /etc/keystone/policy.json
    $ stat -L -c "%a" /etc/keystone/logging.conf
    $ stat -L -c "%a" /etc/keystone/ssl/certs/signing_cert.pem
    $ stat -L -c "%a" /etc/keystone/ssl/private/signing_key.pem
    $ stat -L -c "%a" /etc/keystone/ssl/certs/ca.pem

**Pass:** If permissions are set to 640 or stricter.

**Fail:** If permissions are not set to atleast 640.

Recommended in: :ref:`internally-implemented-authentication-methods`.

Check-Identity-03: is SSL enabled for Identity?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack components communicate with each other using various protocols
and the communication might involve sensitive or confidential data. An
attacker may try to eavesdrop on the channel in order to get access to
sensitive information. Thus all the components must communicate with
each other using a secured communication protocol like HTTPS.

**Pass:** If value of parameter ``enable`` under ``[ssl]`` section in
:file:`/etc/keystone/keystone.conf` is set to ``True``.

**Fail:** If value of parameter ``enable`` under ``[ssl]`` section is
not set to ``True``.

Recommended in: :doc:`../secure-communication`.

Check-Identity-04: Does Identity use strong hashing algorithms for PKI tokens?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

MD5 is a weak and depreciated hashing algorithm. It can be cracked using
bruteforce attack. Identity tokens are sensitive and need to be
protected with a stronger hashing algorithm to prevent unauthorized
disclosure and subsequent access.

**Pass:** If value of parameter ``hash_algorithm`` under ``[token]``
section in :file:`/etc/keystone/keystone.conf` is set to SHA256.

**Fail:** If value of parameter ``hash_algorithm`` under
``[token]``\ section is set to MD5.

Recommended in: :doc:`tokens`.

Check-Identity-05: Is ``max_request_body_size`` set to default (114688)?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The parameter ``max_request_body_size`` defines the maximum body size
per request in bytes. If the maximum size is not defined, the attacker
could craft an arbitary request of large size causing the service to
crash and finally resulting in Denial Of Service attack. Assigning the
maximum value ensures that any malicious oversized request gets blocked
ensuring continued availability of the component.

**Pass:** If value of parameter ``max_request_body_size`` in
:file:`/etc/keystone/keystone.conf` is set to default (114688) or some
reasonable value based on your environment.

**Fail:** If value of parameter ``max_request_body_size`` is not set.

Check-Identity-06: Disable admin token in :file:`/etc/keystone/keystone.conf`
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Admin token is generally used to bootstrap Identity. This token is the
most valuable Identity asset, which could be used to gain cloud admin
privileges.

**Pass:** If ``admin_token`` under ``[DEFAULT]`` section in
:file:`/etc/keystone/keystone.conf` is disabled. And,
AdminTokenAuthMiddleware under ``[filter:admin_token_auth]`` is deleted
from :file:`/etc/keystone/keystone-paste.ini`

**Fail:** If ``admin_token`` under [DEFAULT] section is set and
AdminTokenAuthMiddleware exists in :file:`keystone-paste.ini`.
