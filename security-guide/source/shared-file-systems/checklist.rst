.. _shared_fs_checklist:

=========
Checklist
=========

.. _check_shared_fs_01:

Check-Shared-01: Is user/group ownership of config files set to root/manila?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration files contain critical parameters and information required
for smooth functioning of the component. If an unprivileged user, either
intentionally or accidentally, modifies or deletes any of the parameters or
the file itself then it would cause severe availability issues resulting in a
denial of service to the other end users. Thus user ownership of such critical
configuration files must be set to root and group ownership must be set to
manila.

Run the following commands:

.. code:: console

    $ stat -L -c "%U %G" /etc/manila/manila.conf | egrep "root manila"
    $ stat -L -c "%U %G" /etc/manila/api-paste.ini | egrep "root manila"
    $ stat -L -c "%U %G" /etc/manila/policy.json | egrep "root manila"
    $ stat -L -c "%U %G" /etc/manila/rootwrap.conf | egrep "root manila"

**Pass:** If user and group ownership of all these config files is set
to root and manila respectively. The above commands show output of root manila.

**Fail:** If the above commands does not return any output as the user
and group ownership might have set to any user other than root or any group
other than manila.

.. _check_shared_fs_02:

Check-Shared-02: Are strict permissions set for configuration files?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to the previous check, it is recommended to set strict access
permissions for such configuration files.

Run the following commands:

.. code:: console

    $ stat -L -c "%a" /etc/manila/manila.conf
    $ stat -L -c "%a" /etc/manila/api-paste.ini
    $ stat -L -c "%a" /etc/manila/policy.json
    $ stat -L -c "%a" /etc/manila/rootwrap.conf

**Pass:** If permissions are set to 640 or stricter. The permissions of 640
translates into owner r/w, group r, and no rights to others i.e. "u=rw,g=r,o=".
Note that with :ref:`check_shared_fs_01` and permissions set to 640, root has
read/write access and manila has read access to these configuration files. The
access rights can also be validated using the following command. This command
will only be available on your system if it supports ACLs.

.. code:: console

    $ getfacl --tabular -a /etc/manila/manila.conf
    getfacl: Removing leading '/' from absolute path names
    # file: etc/manila/manila.conf
    USER   root  rw-
    GROUP  manila  r--
    mask         r--
    other        ---

**Fail:** If permissions are not set to at least 640.

.. _check_shared_fs_03:

Check-Shared-03: Is OpenStack Identity used for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack supports various authentication strategies like noauth and keystone.
If the '``noauth``' strategy is used then the users could interact with
OpenStack services without any authentication. This could be a potential risk
since an attacker might gain unauthorized access to the OpenStack components.
Thus it is strongly recommended that all services must be authenticated with
keystone using their service accounts.

**Pass:** If value of parameter ``auth_strategy`` under ``[DEFAULT]`` section
in ``manila.conf`` is set to ``keystone``.

**Fail:** If value of parameter ``auth_strategy`` under ``[DEFAULT]`` section
is set to ``noauth``.

.. _check_shared_fs_04:

Check-Shared-04: Is TLS enabled for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack components communicate with each other using various protocols and
the communication might involve sensitive or confidential data. An attacker may
try to eavesdrop on the channel in order to get access to sensitive
information. Thus all the components must communicate with each other using a
secured communication protocol.

**Pass:** If value of parameter ``auth_protocol`` under
``[keystone_authtoken]`` section in ``manila.conf`` is set to
``https``, or if value of parameter ``identity_uri`` under
``[keystone_authtoken]`` section in ``manila.conf`` is set to
Identity API endpoint starting with ``https://`` and value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``manila.conf`` is set to ``False``.

**Fail:** If value of parameter ``auth_protocol`` under
``[keystone_authtoken]`` section in ``manila.conf`` is set to
``http``, or if value of parameter ``identity_uri`` under
``[keystone_authtoken]`` section in ``manila.conf`` is not set
to Identity API endpoint starting with ``https://`` or value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``manila.conf`` is set to ``True``.

.. _check_shared_fs_05:

Check-Shared-05: Does Shared File Systems contact with Compute over TLS?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack components communicate with each other using various protocols and
the communication might involve sensitive or confidential data. An attacker may
try to eavesdrop on the channel in order to get access to sensitive
information. Thus all the components must communicate with each other using a
secured communication protocol.

**Pass:** If value of parameter ``nova_api_insecure`` under ``[DEFAULT]``
section in ``manila.conf`` is set to ``False``.

**Fail:** If value of parameter ``nova_api_insecure`` under ``[DEFAULT]``
section in ``manila.conf`` is set to ``True``.

.. _check_shared_fs_06:

Check-Shared-06: Does Shared File Systems contact with Networking over TLS?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to previous check (:ref:`check_shared_fs_05`), it is recommended
all the components must communicate with each other using a secured
communication protocol.

**Pass:** If value of parameter ``neutron_api_insecure`` under ``[DEFAULT]``
section in ``manila.conf`` is set to ``False``.

**Fail:** If value of parameter ``neutron_api_insecure`` under ``[DEFAULT]``
section in ``manila.conf`` is set to ``True``.

.. _check_shared_fs_07:

Check-Shared-07: Does Shared File Systems contact with Block Storage over TLS?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to previous check (:ref:`check_shared_fs_05`), it is recommended
all the components must communicate with each other using a secured
communication protocol.

**Pass:** If value of parameter ``cinder_api_insecure`` under ``[DEFAULT]``
section in ``manila.conf`` is set to ``False``.

**Fail:** If value of parameter ``cinder_api_insecure`` under ``[DEFAULT]``
section in ``manila.conf`` is set to ``True``.

.. _check_shared_fs_08:

Check-Shared-08: Is max size for the request body set to default (114688)?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If the maximum body size per request is not defined, the attacker can craft an
arbitrary OSAPI request of large size causing the service to crash and finally
resulting in Denial Of Service attack. Assigning the maximum value ensures that
any malicious oversized request gets blocked ensuring continued availability of
the service.

**Pass:** If value of parameter ``max_request_body_size`` under
``[oslo_middleware]`` section in ``manila.conf`` is set to ``114688``, or
if value of parameter ``osapi_max_request_body_size`` under ``[DEFAULT]``
section in ``manila.conf`` is set to ``114688``. The parameter
``osapi_max_request_body_size`` under ``[DEFAULT]`` is deprecated and it is
better to use [oslo_middleware]/``max_request_body_size``.

**Fail:** If value of parameter ``max_request_body_size`` under
``[oslo_middleware]`` section in ``manila.conf`` is not set to ``114688``,
or if value of parameter ``osapi_max_request_body_size`` under ``[DEFAULT]``
section in ``manila.conf`` is not set to ``114688``.
