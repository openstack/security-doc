================================
Summary of existing technologies
================================

Within OpenStack, there are two solutions recommended for secrets
managment, those being `Barbican <https://docs.openstack.org/barbican/latest/>`_ and `Castellan <https://docs.openstack.org/castellan/latest/>`_. This chapter will
outline different scenarios to help an operator make a choice on which
key manager to use.

A third non supported method is Fixed/Hardcoded keys. It is known that some
OpenStack services have the option to specify keys in their configuration
files. This is the least secure way to operate and we do not recommend
this for any sort of production environment.

Other solutions exist including KeyWhiz, Confidant, Conjur, EJSON, Knox
and Red October, however it is outside the scope of this document to cover
every Key Manager available.

For storage of secrets, it's strongly recommended to a Hardware Security
Modules (HSMs). HSMs can come in multiple forms. The traditional device is a
rack mounted appliance such as the one `shown in the following blog post <https://vakwetu.wordpress.com/2015/11/30/barbican-and-dogtagipa/>`_.
