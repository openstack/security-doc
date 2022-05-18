.. _key_mgr_checklist:

=========
Checklist
=========

.. _check_key_mgr_01:

Check-Key-Manager-01: Is the ownership of config files set to root/barbican?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration files contain critical parameters and information required
for smooth functioning of the component. If an unprivileged user, either
intentionally or accidentally, modifies or deletes any of the parameters
or the file itself then it would cause severe availability issues
resulting in a denial of service to the other end users. User ownership
of such critical configuration files must be set to root and group
ownership must be set to barbican. Additionally, the containing directory
should have the same ownership to ensure that new files are owned correctly.

Run the following commands:

.. code:: console

  $ stat -L -c "%U %G" /etc/barbican/barbican.conf | egrep "root barbican"
  $ stat -L -c "%U %G" /etc/barbican/barbican-api-paste.ini | egrep "root barbican"
  $ stat -L -c "%U %G" /etc/barbican/policy.json | egrep "root barbican"
  $ stat -L -c "%U %G" /etc/barbican | egrep "root barbican"

**Pass:** If user and group ownership of all these config files is set
to root and barbican respectively. The above commands show output of
root / barbican.

**Fail:** If the above commands do not return any output, it is possible
that the user and group ownership may have been set to any user other
than root or any group other than barbican.

.. _check_key_mgr_02:

Check-Key-Manager-02: Are strict permissions set for configuration files?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to the previous check, we recommended to set strict access
permissions for such configuration files.

Run the following commands:

.. code:: console

  $ stat -L -c "%a" /etc/barbican/barbican.conf
  $ stat -L -c "%a" /etc/barbican/barbican-api-paste.ini
  $ stat -L -c "%a" /etc/barbican/policy.json
  $ stat -L -c "%a" /etc/barbican

A broader restriction is also possible: if the containing directory is set
to 750, the guarantee is made that newly created files inside this directory
would have the desired permissions.

**Pass:** If permissions are set to 640 or stricter, or the containing
directory is set to 750. The permissions of 640 translates into owner r/w,
group r, and no rights to others, for example "u=rw,g=r,o=".

.. note::
  With :ref:`check_key_mgr_01` and permissions set to 640, root
  has read/write access and barbican has read access to these
  configuration files. The access rights can also be validated using the
  following command. This command will only be available on your system
  if it supports ACLs.

.. code:: console

  $ getfacl --tabular -a /etc/barbican/barbican.conf
  getfacl: Removing leading '/' from absolute path names
  # file: etc/barbican/barbican.conf
  USER   root  rw-
  GROUP  barbican  r--
  mask         r--
  other        ---

**Fail:** If permissions are set greater than 640.

.. _check_key_mgr_03:

Check-Key-Manager-03: Is OpenStack Identity used for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack supports various authentication strategies like ``noauth`` and
``keystone``. If the ``noauth`` strategy is used then the users can
interact with OpenStack services without any authentication. This could
be a potential risk since an attacker might gain unauthorized access to
the OpenStack components. We strongly recommend that all services must
be authenticated with keystone using their service accounts.

**Pass:** If the parameter ``authtoken`` is listed under the
``pipeline:barbican-api-keystone`` section in ``barbican-api-paste.ini``.

**Fail:** If the parameter ``authtoken`` is missing under the
``pipeline:barbican-api-keystone`` section in ``barbican-api-paste.ini``.

.. _check_key_mgr_04:

Check-Key-Manager-04: Is TLS enabled for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack components communicate with each other using various protocols and
the communication might involve sensitive or confidential data. An attacker may
try to eavesdrop on the channel in order to get access to sensitive
information. All the components must communicate with each other using a
secured communication protocol.

**Pass:** If value of parameter ``www_authenticate_uri`` under
``[keystone_authtoken]`` section in ``/etc/barbican/barbican.conf`` is set to
Identity API endpoint starting with ``https://`` and value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``/etc/barbican/barbican.conf`` is set to ``False``.

**Fail:** If value of parameter ``www_authenticate_uri`` under
``[keystone_authtoken]`` section in ``/etc/barbican/barbican.conf`` is not set
to Identity API endpoint starting with ``https://`` or value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``/etc/barbican/barbican.conf`` is set to ``True``.
