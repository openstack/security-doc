=========
Checklist
=========

.. _check_neutron_01:

Check-Neutron-01: Is user/group ownership of config files set to root/neutron?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration files contain critical parameters and information required
for smooth functioning of the component. If an unprivileged user, either
intentionally or accidentally modifies or deletes any of the parameters or
the file itself then it would cause severe availability issues causing a
denial of service to the other end users. Thus user ownership of such critical
configuration files must be set to root and group ownership must be set to
neutron. Additionally, the containing directory should have the same ownership
to ensure that new files are owned correctly.

Run the following commands:

.. code:: console

    $ stat -L -c "%U %G" /etc/neutron/neutron.conf | egrep "root neutron"
    $ stat -L -c "%U %G" /etc/neutron/api-paste.ini | egrep "root neutron"
    $ stat -L -c "%U %G" /etc/neutron/policy.json | egrep "root neutron"
    $ stat -L -c "%U %G" /etc/neutron/rootwrap.conf | egrep "root neutron"
    $ stat -L -c "%U %G" /etc/neutron | egrep "root neutron"

**Pass:** If user and group ownership of all these config files is set
to root and neutron respectively. The above commands show output of root
neutron.

**Fail:** If the above commands does not return any output as the user
and group ownership might have set to any user other than root or any group
other than neutron.

.. _check_neutron_02:

Check-Neutron-02: Are strict permissions set for configuration files?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to the previous check, it is recommended to set strict access
permissions for such configuration files.

Run the following commands:

.. code:: console

    $ stat -L -c "%a" /etc/neutron/neutron.conf
    $ stat -L -c "%a" /etc/neutron/api-paste.ini
    $ stat -L -c "%a" /etc/neutron/policy.json
    $ stat -L -c "%a" /etc/neutron/rootwrap.conf
    $ stat -L -c "%a" /etc/neutron

A broader restriction is also possible: if the containing directory is set
to 750, the guarantee is made that newly created files inside this directory
would have the desired permissions.

**Pass:** If permissions are set to 640 or stricter, or the containing
directory is set to 750. The permissions of 640 translates into owner r/w,
group r, and no rights to others i.e. "u=rw,g=r,o=".

Note that with :ref:`check_neutron_01` and permissions set to 640, root has
read/write access and neutron has read access to these configuration files. The
access rights can also be validated using the following command. This command
will only be available on your system if it supports ACLs.

.. code:: console

    $ getfacl --tabular -a /etc/neutron/neutron.conf
    getfacl: Removing leading '/' from absolute path names
    # file: etc/neutron/neutron.conf
    USER   root     rw-
    GROUP  neutron  r--
    mask            r--
    other           ---

**Fail:** If permissions are not set to at least 640.

.. _check_neutron_03:

Check-Neutron-03: Is keystone used for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack supports various authentication strategies like noauth, keystone etc.
If the 'noauth' strategy is used then the users could interact with OpenStack
services without any authentication. This could be a potential risk since an
attacker might gain unauthorized access to the OpenStack components. Thus it is
strongly recommended that all services must be authenticated with keystone
using their service accounts.

**Pass:** If value of parameter ``auth_strategy`` under ``[DEFAULT]`` section
in ``/etc/neutron/neutron.conf`` is set to ``keystone``.

**Fail:** If value of parameter ``auth_strategy`` under ``[DEFAULT]`` section
is set to ``noauth`` or ``noauth2``.

.. _check_neutron_04:

Check-Neutron-04: Is secure protocol used for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack components communicate with each other using various protocols and
the communication might involve sensitive / confidential data. An attacker may
try to eavesdrop on the channel in order to get access to sensitive
information. Thus all the components must communicate with each other using a
secured communication protocol.

**Pass:** If value of parameter ``www_authenticate_uri`` under
``[keystone_authtoken]`` section in ``/etc/neutron/neutron.conf`` is set to
Identity API endpoint starting with ``https://`` and value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``/etc/neutron/neutron.conf`` is set to ``False``.

**Fail:** If value of parameter ``www_authenticate_uri`` under
``[keystone_authtoken]`` section in ``/etc/neutron/neutron.conf`` is not set to
Identity API endpoint starting with ``https://`` or value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``/etc/neutron/neutron.conf`` is set to ``True``.

.. _check_neutron_05:

Check-Neutron-05: Is TLS enabled on Neutron API server?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to the previous check, it is recommended to enable secure communication
on API server.

**Pass:** If value of parameter ``use_ssl`` under ``[DEFAULT]``
section in ``/etc/neutron/neutron.conf`` is set to ``True``.

**Fail:** If value of parameter ``use_ssl`` under ``[DEFAULT]``
section in ``/etc/neutron/neutron.conf`` is set to ``False``.
