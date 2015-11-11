=========
Checklist
=========

.. _check_dashboard_01:

Check-Dashboard-01: Is user/group of config files set to root/horizon?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration files contain critical parameters and information required
for smooth functioning of the component. If an unprivileged user, either
intentionally or accidentally modifies or deletes any of the parameters or
the file itself then it would cause severe availability issues causing a
denial of service to the other end users. Thus user ownership of such critical
configuration files must be set to root and group ownership must be set to
horizon.

Run the following commands:

.. code:: console

    $ stat -L -c "%U %G"  /etc/openstack-dashboard/local_settings.py | egrep "root horizon"

**Pass:** If user and group ownership of the config file is set to root and
horizon respectively. The above commands show output of root horizon.

**Fail:** If the above commands does not return any output as the user
and group ownership might have set to any user other than root or any group
other than horizon.

.. _check_dashboard_02:

Check-Dashboard-02: Are strict permissions set for horizon configuration files?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to the previous check, it is recommended to set strict access
permissions for such configuration files.

Run the following commands:

.. code:: console

    $ stat -L -c "%a" /etc/openstack-dashboard/local_settings.py

**Pass:** If permissions are set to 640 or stricter. The permissions of 640
translates into owner r/w, group r, and no rights to others i.e. "u=rw,g=r,o=".
Note that with :ref:`check_dashboard_01` and permissions set to 640, root has
read/write access and horizon has read access to these configuration files. The
access rights can also be validated using the following command. This command
will only be available on your system if it supports ACLs.

.. code:: console

    $ getfacl --tabular -a /etc/openstack-dashboard/local_settings.py
    getfacl: Removing leading '/' from absolute path names
    # file: etc/openstack-dashboard/local_settings.py
    USER   root     rw-
    GROUP  horizon  r--
    mask            r--
    other           ---

**Fail:** If permissions are not set to at least 640.

.. _check_dashboard_03:

Check-Dashboard-03: Is ``USE_SSL`` parameter set to ``True``?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Openstack services communicate with each other using various protocols and the
communication might involve sensitive/confidential information. An attacker
may try to eavesdrop on the channel in order to get access to sensitive
information. Thus all the services must communicate with each other using a
secured communication protocol like HTTPS.

**Pass:** If value of parameter ``USE_SSL`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``True``.

**Fail:** If value of parameter ``USE_SSL`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``False``.

Recommended in: :doc:`https-hsts-xss-ssrf`.

.. _check_dashboard_04:

Check-Dashboard-04: Is ``CSRF_COOKIE_SECURE`` parameter set to ``True``?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CSRF (Cross-site request forgery) is an attack which forces an end user to
execute unauthorized commands on a web application in which he/she is currently
authenticated. A successful CSRF exploit can compromise end user data and
operations in case of normal user. If the targeted end user has admin
privileges, this can compromise the entire web application.

**Pass:** If value of parameter ``CSRF_COOKIE_SECURE`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``True``.

**Fail:** If value of parameter ``CSRF_COOKIE_SECURE`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``False``.

Recommended in: :doc:`cookies`.

.. _check_dashboard_05:

Check-Dashboard-05: Is ``SESSION_COOKIE_SECURE`` parameter set to ``True``?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The "SECURE" cookie attribute instructs web browsers to only send the cookie
through an encrypted HTTPS (SSL/TLS) connection. This session protection
mechanism is mandatory to prevent the disclosure of the session ID through
MitM (Man-in-the-Middle) attacks. It ensures that an attacker cannot simply
capture the session ID from web browser traffic.

**Pass:** If value of parameter ``SESSION_COOKIE_SECURE`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``True``.

**Fail:** If value of parameter ``SESSION_COOKIE_SECURE`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``False``.

Recommended in: :doc:`cookies`.


.. _check_dashboard_06:

Check-Dashboard-06: Is ``SESSION_COOKIE_HTTPONLY`` parameter set to ``True``?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The “HTTPONLY” cookie attribute instructs web browsers not to allow scripts
(e.g. JavaScript or VBscript) an ability to access the cookies via the DOM
``document.cookie`` object. This session ID protection is mandatory to prevent
session ID stealing through XSS attacks.

**Pass:** If value of parameter ``SESSION_COOKIE_HTTPONLY`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``True``.

**Fail:** If value of parameter ``SESSION_COOKIE_HTTPONLY`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``False``.

Recommended in: :doc:`cookies`.

.. _check_dashboard_07:

Check-Dashboard-07: Is ``password_autocomplete`` set to ``False``?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Common feature that applications use to provide users a convenience is to cache
the password locally in the browser (on the client machine) and having it
'pre-typed' in all subsequent requests. While this feature can be perceived as
extremely friendly for the average user, at the same time, it introduces a
flaw, as the user account becomes easily accessible to anyone that uses the
same account on the client machine and thus may lead to compromise of the user
account.

**Pass:** If value of parameter ``password_autocomplete`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``off``.

**Fail:** If value of parameter ``password_autocomplete`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``on``.

.. _check_dashboard_08:

Check-Dashboard-08: Is ``disable_password_reveal`` set to ``True``?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to the previous check, it is recommended not to reveal password fields.

**Pass:** If value of parameter ``disable_password_reveal`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``True``.

**Fail:** If value of parameter ``disable_password_reveal`` in
:file:`/etc/openstack-dashboard/local_settings.py` is set to ``False``.

.. Note::

    This option was introduced in Kilo release.
