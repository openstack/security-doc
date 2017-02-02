=========
Checklist
=========

.. _check_compute_01:

Check-Compute-01: Is user/group ownership of config files set to root/nova?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration files contain critical parameters and information required
for smooth functioning of the component. If an unprivileged user, either
intentionally or accidentally modifies or deletes any of the parameters or
the file itself then it would cause severe availability issues causing a
denial of service to the other end users. Thus user ownership of such critical
configuration files must be set to root and group ownership must be set to
nova.

Run the following commands:

.. code:: console

    $ stat -L -c "%U %G" /etc/nova/nova.conf | egrep "root nova"
    $ stat -L -c "%U %G" /etc/nova/api-paste.ini | egrep "root nova"
    $ stat -L -c "%U %G" /etc/nova/policy.json | egrep "root nova"
    $ stat -L -c "%U %G" /etc/nova/rootwrap.conf | egrep "root nova"

**Pass:** If user and group ownership of all these config files is set
to root and nova respectively. The above commands show output of root nova.

**Fail:** If the above commands does not return any output as the user
and group ownership might have set to any user other than root or any group
other than nova.

Recommended in: :doc:`../compute`.

.. _check_compute_02:

Check-Compute-02: Are strict permissions set for configuration files?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to the previous check, it is recommended to set strict access
permissions for such configuration files.

Run the following commands:

.. code:: console

    $ stat -L -c "%a" /etc/nova/nova.conf
    $ stat -L -c "%a" /etc/nova/api-paste.ini
    $ stat -L -c "%a" /etc/nova/policy.json
    $ stat -L -c "%a" /etc/nova/rootwrap.conf

**Pass:** If permissions are set to 640 or stricter. The permissions of 640
translates into owner r/w, group r, and no rights to others i.e. "u=rw,g=r,o=".
Note that with :ref:`check_compute_01` and permissions set to 640, root has
read/write access and nova has read access to these configuration files. The
access rights can also be validated using the following command. This command
will only be available on your system if it supports ACLs.

.. code:: console

    $ getfacl --tabular -a /etc/nova/nova.conf
    getfacl: Removing leading '/' from absolute path names
    # file: etc/nova/nova.conf
    USER   root  rw-
    GROUP  nova  r--
    mask         r--
    other        ---

**Fail:** If permissions are not set to at least 640.

Recommended in: :doc:`../compute`.

.. _check_compute_03:

Check-Compute-03: Is keystone used for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack supports various authentication strategies like noauth, keystone etc.
If the 'noauth' strategy is used then the users could interact with OpenStack
services without any authentication. This could be a potential risk since an
attacker might gain unauthorized access to the OpenStack components. Thus it is
strongly recommended that all services must be authenticated with keystone
using their service accounts.

**Pass:** If value of parameter ``auth_strategy`` under ``[DEFAULT]`` section
in ``/etc/nova/nova.conf`` is set to ``keystone``.

**Fail:** If value of parameter ``auth_strategy`` under ``[DEFAULT]`` section
is set to ``noauth`` or ``noauth2``.

.. _check_compute_04:

Check-Compute-04: Is secure protocol used for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack components communicate with each other using various protocols and
the communication might involve sensitive / confidential data. An attacker may
try to eavesdrop on the channel in order to get access to sensitive
information. Thus all the components must communicate with each other using a
secured communication protocol.

**Pass:** If value of parameter ``auth_uri`` under
``[keystone_authtoken]`` section in ``/etc/nova/nova.conf`` is set to
Identity API endpoint starting with ``https://`` and value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``/etc/nova/nova.conf`` is set to ``False``.

**Fail:** If value of parameter ``auth_uri`` under
``[keystone_authtoken]`` section in ``/etc/nova/nova.conf`` is not set to
Identity API endpoint starting with ``https://`` or value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``/etc/nova/nova.conf`` is set to ``True``.

.. _check_compute_05:

Check-Compute-05: Does Nova communicate with Glance securely?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack components communicate with each other using various protocols and
the communication might involve sensitive / confidential data. An attacker may
try to eavesdrop on the channel in order to get access to sensitive
information. Thus all the components must communicate with each other using a
secured communication protocol.

**Pass:** If value of parameter ``glance_api_insecure`` under ``[DEFAULT]``
section in ``/etc/nova/nova.conf`` is set to ``False``, or if value of
parameter ``api_insecure`` under ``[glance]`` section in
``/etc/nova/nova.conf`` is set to ``False``.

**Fail:** If value of parameter ``glance_api_insecure`` under ``[DEFAULT]``
section in ``/etc/nova/nova.conf`` is set to ``True``, or if value of
parameter ``api_insecure`` under ``[glance]`` section in
``/etc/nova/nova.conf`` is set to ``True``.
