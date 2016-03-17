OpenStack Security Guide documentation
======================================

This document provides specific advice from the security documentation
team about contributing to the
`reStructuredText <http://www.sphinx-doc.org/en/stable/rest.html>`_
version of the ``OpenStack Security Guide``. It contains the team's
preferences for new patches and bug reports.

For information about the structure of this repository, building the
documentation, bug reporting locations, or general contribution notes,
please see the
`security-doc repository documentation <https://github.com/openstack/security-doc/>`_.

Reporting bugs
--------------

When reporting bugs to the ``OpenStack Security Guide``, the team has a
preference for scoping the bugs to the chapters in which they occur,
even for bugs which may require a similar change across disparate
sections of the guide. This breakdown gives the team members a clearer
view of the specific bug cases and makes the review process quicker as
the individual reviews tend to be more manageable.

Creating reviews
----------------

In a similar style as bug reporting, the security documentation team
prefers reviews which are scoped at the chapter level. For example, if
proposing a change which will refactor the syntax of a specific
element, the change should be submitted on a per-chapter basis.

Reviews should also be scoped to cover a single issue. When possible,
please split your reviews based on the bug topics that are being
addressed.

General note on consistency
---------------------------

These guidelines may seem overly specific in the terms that they
define, but they have evolved over several cycles of working on the
``OpenStack Security Guide``. In general, the team prefers these stylistic
choices as they make the review and improvement process much smoother.
That being said, for very small changes, or in cases where it would
create an excessive amount of noise, the boundaries defined by these
guidelines can be stretched. As always, please use your best judgment
or ask the security documentation team for advice.
