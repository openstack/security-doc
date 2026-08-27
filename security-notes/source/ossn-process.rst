:orphan:

================================
OpenStack Security Notes Process
================================

Security Notes (OSSN) advise users of security related issues that do not
warrant an advisory (OSSA).

Where an OSSA is normally "apply this patch and you are done", an OSSN is
rarely that simple. Most notes exist to inform operators about a
well-known but poorly documented issue, or about an insecure feature that
cannot safely be removed. A note may carry patches, but those patches are
usually not sufficient on their own: the fix may only be available on
master, or it may add an opt-in configuration option that defaults to the
old behaviour on stable branches, so operators have to both apply the
patch and change their configuration. Some notes have no patch at all and
only describe a workaround.

A note should therefore state plainly what an operator has to do, and
what remains exposed if they cannot do it.

The Vulnerability Management Team's `report taxonomy
<https://security.openstack.org/vmt-process.html#report-taxonomy>`_
assigns classes B1, B2 and B3 to a Security Note, and classes C1, C2 and
D to a potential Security Note.

Process
=======

#. Claim the next unused ``OSSN-XXXX`` number. Note that the sequence has
   gaps (0040, 0041, 0050, 0051, 0071, 0072) which are not to be reused.
#. Copy ``security-notes/template.yaml`` to
   ``security-notes/OSSN-XXXX.yaml`` and fill it in.
#. Propose the change to ``openstack/security-doc`` for review.
#. Once merged, announce the note as described below.

Fields
======

Each note is a single YAML file. The fields below are rendered in this
order by ``security-notes/source/ossn.jinja``. ``template.yaml`` documents
the YAML and reStructuredText conventions to follow within them.

.. list-table::
   :header-rows: 1
   :widths: 25 15 60

   * - Field
     - Required
     - Content
   * - ``id``
     - yes
     - ``OSSN-XXXX``, matching the file name.
   * - ``title``
     - yes
     - Single sentence, no trailing period.
   * - ``affected-services``
     - yes
     - Affected software and version ranges. Either a block scalar of
       ``- item`` lines or a YAML list; both render as a bullet list.
   * - ``summary``
     - yes
     - A few sentences describing the issue at a high level.
   * - ``discussion``
     - yes
     - What the issue is, how it can be exploited, and its impact.
   * - ``recommended-actions``
     - no
     - Remediation: configuration changes, workarounds and patch links.
   * - ``credits``
     - no
     - Reporter name and affiliation. A string, or a list of strings for
       multiple reporters.
   * - ``references``
     - yes
     - A ``links:`` list; each entry has a ``description`` and a ``url``.
   * - ``author``
     - no
     - Name and company of the note's author.

Recommended actions
===================

Describe everything the operator must do, in order. If applying a patch
is not enough by itself, say so explicitly and show the configuration
change alongside it.

List review links under a ``**Patches:**`` label, one bullet per release::

  **Patches:**

  - 2026.2/hibiscus (development): https://review.opendev.org/XXXXXX
  - 2026.1/gazpacho: https://review.opendev.org/XXXXXX

Where a release has several patches, or several components are affected,
group the links under a bold label per release or component instead.
``template.yaml`` has worked examples of both layouts.

If a fix only landed on master, or was not backported because it is
backwards incompatible, state that and note that operators are welcome to
backport it themselves. If there is no fix, describe the workaround and
what risk remains.

Announcing
==========

Announcement mirrors the non-embargoed OSSA process. Retrieve the
generated RST for the merged note from the published documentation, then
send two separate emails, to avoid off-topic replies to the oss-security
list:

* *To:* ``openstack-announce@lists.openstack.org``,
  ``openstack-discuss@lists.openstack.org``
* *To:* ``oss-security@lists.openwall.com``

Both emails set *Reply-To:* ``openstack-discuss@lists.openstack.org`` and
share the same subject and body:

* *Subject:* ``[OSSN-XXXX] $TITLE``
* *Body:* the generated RST document

Email must be GPG-signed.
