=========
Checklist
=========

.. _check_block_01:

Check-Block-01: Is user/group ownership of config files set to root/cinder?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration files contain critical parameters and information required
for smooth functioning of the component. If an unprivileged user, either
intentionally or accidentally, modifies or deletes any of the parameters or
the file itself then it would cause severe availability issues resulting in a
denial of service to the other end users. Thus user ownership of such critical
configuration files must be set to root and group ownership must be set to
cinder.

Run the following commands:

.. code:: console

    $ stat -L -c "%U %G" /etc/cinder/cinder.conf | egrep "root cinder"
    $ stat -L -c "%U %G" /etc/cinder/api-paste.ini | egrep "root cinder"
    $ stat -L -c "%U %G" /etc/cinder/policy.json | egrep "root cinder"
    $ stat -L -c "%U %G" /etc/cinder/rootwrap.conf | egrep "root cinder"

**Pass:** If user and group ownership of all these config files is set
to root and cinder respectively. The above commands show output of root cinder.

**Fail:** If the above commands does not return any output as the user
and group ownership might have set to any user other than root or any group
other than cinder.

.. _check_block_02:

Check-Block-02: Are strict permissions set for configuration files?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to the previous check, we recommend setting strict access permissions
for such configuration files.

Run the following commands:

.. code:: console

    $ stat -L -c "%a" /etc/cinder/cinder.conf
    $ stat -L -c "%a" /etc/cinder/api-paste.ini
    $ stat -L -c "%a" /etc/cinder/policy.json
    $ stat -L -c "%a" /etc/cinder/rootwrap.conf

**Pass:** If permissions are set to 640 or stricter. The permissions of 640
translates into owner r/w, group r, and no rights to others i.e. "u=rw,g=r,o=".
Note that with :ref:`check_block_01` and permissions set to 640, root has
read/write access and cinder has read access to these configuration files. The
access rights can also be validated using the following command. This command
will only be available on your system if it supports ACLs.

.. code:: console

    $ getfacl --tabular -a /etc/cinder/cinder.conf
    getfacl: Removing leading '/' from absolute path names
    # file: etc/cinder/cinder.conf
    USER   root  rw-
    GROUP  cinder  r--
    mask         r--
    other        ---

**Fail:** If permissions are not set to at least 640.

.. _check_block_03:

Check-Block-03: Is keystone used for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack supports various authentication strategies like noauth, keystone etc.
If the 'noauth' strategy is used then the users could interact with OpenStack
services without any authentication. This could be a potential risk since an
attacker might gain unauthorized access to the OpenStack components. Thus we
strongly recommend that all services must be authenticated with keystone using
their service accounts.

**Pass:** If value of parameter ``auth_strategy`` under ``[DEFAULT]`` section
in ``/etc/cinder/cinder.conf`` is set to ``keystone``.

**Fail:** If value of parameter ``auth_strategy`` under ``[DEFAULT]`` section
is set to ``noauth``.

.. _check_block_04:

Check-Block-04: Is TLS enabled for authentication?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack components communicate with each other using various protocols and
the communication might involve sensitive / confidential data. An attacker may
try to eavesdrop on the channel in order to get access to sensitive
information. Thus all the components must communicate with each other using a
secured communication protocol.

**Pass:** If value of parameter ``www_authenticate_uri`` under
``[keystone_authtoken]`` section in ``/etc/cinder/cinder.conf`` is set to
Identity API endpoint starting with ``https://`` and value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``/etc/cinder/cinder.conf`` is set to ``False``.

**Fail:** If value of parameter ``www_authenticate_uri`` under
``[keystone_authtoken]`` section in ``/etc/cinder/cinder.conf`` is not set to
Identity API endpoint starting with ``https://`` or value of parameter
``insecure`` under the same ``[keystone_authtoken]`` section in the same
``/etc/cinder/cinder.conf`` is set to ``True``.

.. _check_block_05:

Check-Block-05: Does cinder communicate with nova over TLS?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack components communicate with each other using various protocols and
the communication might involve sensitive / confidential data. An attacker may
try to eavesdrop on the channel in order to get access to sensitive
information. Thus all the components must communicate with each other using a
secured communication protocol.

**Pass:** If value of parameter ``nova_api_insecure`` under ``[DEFAULT]``
section in ``/etc/cinder/cinder.conf`` is set to ``False``.

**Fail:** If value of parameter ``nova_api_insecure`` under ``[DEFAULT]``
section in ``/etc/cinder/cinder.conf`` is set to ``True``.

.. _check_block_06:

Check-Block-06: Does cinder communicate with glance over TLS?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to previous check (:ref:`check_block_05`), we recommend that all
components communicate with each other using a secured communication protocol.

**Pass:** If value of parameter ``glance_api_insecure`` under ``[DEFAULT]``
section in ``/etc/cinder/cinder.conf`` is set to ``False`` and value of
parameter ``glance_api_servers`` is set to a value starting with ``https://``.

**Fail:** If value of parameter ``glance_api_insecure`` under ``[DEFAULT]``
section in ``/etc/cinder/cinder.conf`` is set to ``True`` or the value of
parameter ``glance_api_servers`` is set to a value that does not start with
``https://``.

.. _check_block_07:

Check-Block-07: Is NAS operating in a secure environment?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cinder supports an NFS driver which works differently than a traditional block
storage driver. The NFS driver does not actually allow an instance to access a
storage device at the block level. Instead, files are created on an NFS share
and mapped to instances, which emulates a block device. Cinder supports secure
configuration for such files by controlling the file permissions when cinder
volumes are created. Cinder configuration can also control whether file
operations are run as the root user or the current OpenStack process user.

**Pass:** If value of parameter ``nas_secure_file_permissions`` under
``[DEFAULT]`` section in ``/etc/cinder/cinder.conf`` is set to ``auto``.
When set to ``auto``, a check is done during cinder startup to determine if
there are existing cinder volumes, no volumes will set the option to ``True``,
and use secure file permissions. The detection of existing volumes will set the
option to ``False``, and use the current insecure method of handling file
permissions. If value of parameter ``nas_secure_file_operations`` under
``[DEFAULT]`` section in ``/etc/cinder/cinder.conf`` is set to ``auto``.
When set to "auto", a check is done during cinder startup to determine if there
are existing cinder volumes, no volumes will set the option to ``True``, be
secure and do NOT run as the ``root`` user. The detection of existing volumes
will set the option to ``False``, and use the current method of running
operations as the ``root`` user. For new installations, a "marker file" is
written so that subsequent restarts of cinder will know what the original
determination had been.

**Fail:** If value of parameter ``nas_secure_file_permissions`` under
``[DEFAULT]`` section in ``/etc/cinder/cinder.conf`` is set to ``False``
and if value of parameter ``nas_secure_file_operations`` under
``[DEFAULT]`` section in ``/etc/cinder/cinder.conf`` is set to ``False``.


.. _check_block_08:

Check-Block-08: Is max size for the body of a request set to default (114688)?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If the maximum body size per request is not defined, the attacker can craft an
arbitrary osapi request of large size causing the service to crash and finally
resulting in Denial Of Service attack. Assigning the maximum value ensures that
any malicious oversized request gets blocked ensuring continued availability of
the service.

**Pass:** If value of parameter ``osapi_max_request_body_size`` under
``[DEFAULT]`` section in ``/etc/cinder/cinder.conf`` is set to ``114688``
or if value of parameter ``max_request_body_size`` under ``[oslo_middleware]``
section in ``/etc/cinder/cinder.conf`` is set to ``114688``.

**Fail:** If value of parameter ``osapi_max_request_body_size`` under
``[DEFAULT]`` section in ``/etc/cinder/cinder.conf`` is not set to
``114688`` or if value of parameter ``max_request_body_size`` under
``[oslo_middleware]`` section in ``/etc/cinder/cinder.conf`` is not set to
``114688``.

.. _check_block_09:

Check-Block-09: Is the volume encryption feature enabled?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Unencrypted volume data makes volume-hosting platforms especially high-value
targets for attackers, as it allows the attacker to read the data for many
different VMs. In addition, the physical storage medium could be stolen,
remounted, and accessed from a different machine. Encrypting volume data
mitigates these risks and provides defense-in-depth to volume-hosting
platforms. Block Storage (cinder) is able to encrypt volume data before it is
written to disk, and we recommend that the volume encryption feature is
enabled. See the `Volume Encryption
<https://docs.openstack.org/cinder/latest/configuration/block-storage/volume-encryption.html>`__
section of the Openstack Cinder Service Configuration documentation for
instructions.

**Pass:** If 1) the value of parameter ``backend`` under the ``[key_manager]``
section in ``/etc/cinder/cinder.conf`` is set, 2) the value of parameter
``backend`` under ``[key_manager]`` in ``/etc/nova/nova.conf`` is set,
and 3) if the instructions in the documentation referenced above are properly
followed.

To verify further, perform these steps after completing the volume encryption
setup and creating the volume-type for LUKS as described in the documentation
referenced above.

#. Create a VM:

   .. code-block:: console

      $ openstack server create --image cirros-0.3.1-x86_64-disk --flavor m1.tiny TESTVM

#. Create an encrypted volume and attach it to your VM:

   .. code-block:: console

      $ openstack volume create --size 1 --type LUKS 'encrypted volume'
      $ openstack volume list
      $ openstack server add volume --device /dev/vdb TESTVM 'encrypted volume'

#. On the VM, send some text to the newly attached volume and synchronize it:

   .. code-block:: console

      # echo "Hello, world (encrypted /dev/vdb)" >> /dev/vdb
      # sync && sleep 2

#. On the system hosting cinder volume services, synchronize to flush the
   I/O cache then test to see if your string can be found:

   .. code-block:: console

      # sync && sleep 2
      # strings /dev/stack-volumes/volume-* | grep "Hello"

The search should not return the string written to the encrypted volume.

**Fail:** If value of parameter ``backend`` under ``[key_manager]`` section
in ``/etc/cinder/cinder.conf`` is not set, or if the value of parameter
``backend`` under ``[key_manager]`` section in ``/etc/nova/nova.conf``
is not set, or if the instructions in the documentation referenced above are
not properly followed.
