============
Case studies
============

Earlier in :doc:`../introduction/introduction-to-case-studies` we
introduced the Alice and Bob case studies where Alice is deploying
a private government cloud and Bob is deploying a public cloud each
with different security requirements. Here we discuss how Alice and
Bob would architect their clouds with respect to instance entropy,
scheduling instances, trusted images, and instance migrations.

Alice's private cloud
~~~~~~~~~~~~~~~~~~~~~

Earlier in :ref:`management-case-study-alice`
Alice issued a Request for Product (or RFP) to major hardware
vendors that outlined her performance and form factor needs.
This RFP includes the requirement for a processor architecture
with rdrand support (currently Ivy Bridge or Haswell). When the
hardware has been delivered and is being configured, Alice will
use the entropy-gathering daemon (egd) in libvirt to ensure
sufficient entropy and the ability to feed that entropy to
instances. She also enables 'trusted compute pools' for boot
time attestation of the image that will be compared to a hash
from the 'golden images.' She configures the
``.bash_profile`` to log all commands, and
sends those to the event monitoring collector. As users are
expected to only have access to the application, and not the
instance behind it, Alice installs a host intrusion detection
system (HIDS) agent on the instance as well to monitor and
export system events, and also ensures her internal public
certificate is installed into the certificate store on the
system. Alice is also aware that a side effect of this
architecture is that Alice's team will be expected to manage
all of the instances in the environment.

Bob's public cloud
~~~~~~~~~~~~~~~~~~

Bob is aware that entropy will be a concern for some of his customers,
such as those in the financial industry. However, due to the added cost
and complexity, Bob has decided to forgo integrating hardware entropy
into the first iteration of his cloud. He adds hardware entropy as a
fast-follow to do for a later improvement for the second generation of
his cloud architecture.

Bob is interested in ensuring that customers receive a high quality of
service. He is concerned that providing excess explicit user control
over instance scheduling could negatively impact the quality of
service. As a result, he disables this feature. Bob provides images in
the cloud from a known trusted source for users to use. Additionally,
he allows users to upload their own images. However, users generally
cannot share their images. This helps prevent a user from sharing a
malicious image, which could negatively impact the security of other
users in the cloud.

For migrations, Bob wants to enable secure instance migrations
in order to support rolling upgrades with minimal user
downtime. Bob ensures that all migrations occur on an isolated
VLAN. He plans to defer implementing encrypted migrations
until this is better supported in ``nova``
client tools. As a result, he makes a note to track this carefully
and switch to encrypted migrations as soon as possible.
