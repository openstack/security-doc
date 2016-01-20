=========
Passwords
=========

Password management should be an integral part of your cloud administration
plan. A definitive tutorial about passwords is beyond the scope of this book;
however, cloud administrators should refer to the best practices recommended
in Chapter 4 of NIST Special Publication
`Guide to Enterprise Password Management <http://csrc.nist.gov/publications/drafts/800-118/draft-sp800-118.pdf>`_.

Browser-based access to the OpenStack cloud, whether through the dashboard or
other applications, introduces additional considerations. Modern browsers all
support some form of password storage and autofilling of credentials for
remembered sites. This can be useful when using strong passwords that cannot
be easily remembered or typed, but may cause the browser to become the weak
link if the physical security of the client is compromised. If the
browser's password store itself is not protected by a strong password, or if
the password store is allowed to remain unlocked for the duration of the
session, unauthorized access to your system can be easily obtained.

Password management applications such as `KeePassX <http://www.keepassx.org>`_
and `Password Safe <http://www.pwsafe.org>`_ can be useful as most support the
generation of strong passwords and periodic reminders to generate new
passwords. Most importantly, the password store remains unlocked only
briefly, which reduces the risk of password exposure and unauthorized resource
access through browser or system compromise.

