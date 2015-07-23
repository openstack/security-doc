==========
Secret key
==========

The dashboard depends on a shared ``SECRET_KEY``
setting for some security functions. The secret key should be a
randomly generated string at least 64 characters long, which must
be shared across all active dashboard instances. Compromise of this
key may allow a remote attacker to execute arbitrary code. Rotating
this key invalidates existing user sessions and caching. Do not
commit this key to public repositories.
