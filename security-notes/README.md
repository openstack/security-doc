OpenStack Security Notes (OSSN)
===============================

The OpenStack Security Group (OSSG) publishes Security Notes to advise users
of security related issues. Security notes are similar to advisories; they
address vulnerabilities in 3rd party tools typically used within OpenStack
deployments and provide guidance on common configuration mistakes that can
result in an insecure operating environment.

Repository Layout
-----------------

This repository contains published Security Notes and templates that should
be used when creating new Security Notes.

    OSSN-XXXX.yaml  - Security Notes in YAML format (use for new notes)
    template.yaml   - YAML template for creating new Security Notes

    OSSN-XXXX - Legacy Security Notes in plain text format (historical)
    template.txt - Legacy plain text template (historical)

New Security Notes should be authored directly in YAML format, following
the same approach used for OSSAs. Use template.yaml as a template.
    

Useful Links
------------

A list of published Security Notes is available here:

    https://wiki.openstack.org/wiki/Security_Notes

The process used to create new Security Notes is available here:

    https://wiki.openstack.org/wiki/Security/Security_Note_Process

How the Build Pipeline Works
-----------------------------

Security Notes are published via a Sphinx build pipeline that mirrors the
approach used for OSSAs (OpenStack Security Advisories).

At build time, the Sphinx extension ossn.py reads all OSSN-XXXX.yaml
files from the security-notes/ directory, renders each one through the
ossn.jinja Jinja2 template, and writes the resulting RST files to
security-notes/source/. Sphinx then builds those RST files into HTML.

The generated RST files and build output are excluded from git via
.gitignore. Do not commit them.

To build locally::

    python3 -m venv .venv && source .venv/bin/activate
    pip install tox
    tox -e publishdocs

To run the linter::

    tox -e linters

To preview the built HTML::

    open security-notes/build/html/index.html

