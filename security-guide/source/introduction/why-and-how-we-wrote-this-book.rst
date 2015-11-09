==============================
Why and how we wrote this book
==============================

As OpenStack adoption continues to grow and the product matures, security has
become a priority. The OpenStack Security Group has recognized the need for a
comprehensive and authoritative security guide. The **OpenStack Security
Guide** has been written to provide an overview of security best practices,
guidelines, and recommendations for increasing the security of an OpenStack
deployment. The authors bring their expertise from deploying and securing
OpenStack in a variety of environments.

This guide augments the `OpenStack Operations Guide
<http://docs.openstack.org/ops/>`__ and can be referenced to harden existing
OpenStack deployments or to evaluate the security controls of OpenStack cloud
providers.

Objectives
~~~~~~~~~~

-  Identify the security domains in OpenStack
-  Provide guidance to secure your OpenStack deployment
-  Highlight security concerns and potential mitigations in present day
   OpenStack
-  Discuss upcoming security features
-  To provide a community driven facility for knowledge capture and
   dissemination

How
~~~

As with the OpenStack Operations Guide, we followed the book sprint
methodology. The book sprint process allows for rapid development and
production of large bodies of written work. Coordinators from the OpenStack
Security Group re-enlisted the services of Adam Hyde as facilitator. Corporate
support was obtained and the project was formally announced during the
OpenStack summit in Portland, Oregon.

The team converged in Annapolis, MD due to the close proximity of some key
members of the group. This was a remarkable collaboration between public sector
intelligence community members, silicon valley startups and some large,
well-known technology companies. The book sprint ran during the last week in
June 2013 and the first edition was created in five days.

.. image:: ../figures/group.png

The team included:

-  **Bryan D. Payne**, Nebula

   Dr. Bryan D. Payne is the Director of Security Research at Nebula and
   co-founder of the OpenStack Security Group (OSSG). Prior to joining Nebula,
   he worked at Sandia National Labs, the National Security Agency, BAE
   Systems, and IBM Research. He graduated with a Ph.D. in Computer Science
   from the Georgia Tech College of Computing, specializing in systems
   security. Bryan was the editor and lead for the OpenStack Security Guide,
   responsible for its continued growth for the two years after it was written.

-  **Robert Clark**, HP

   Robert Clark is the Lead Security Architect for HP Cloud Services and
   co-founder of the OpenStack Security Group (OSSG). Prior to being
   recruited by HP, he worked in the UK Intelligence Community. Robert has a
   strong background in threat modeling, security architecture and
   virtualization technology. Robert has a master's degree in Software
   Engineering from the University of Wales.

-  **Keith Basil**, Red Hat

   Keith Basil is a Principal Product Manager for Red Hat OpenStack and is
   focused on Red Hat's OpenStack product management, development and strategy.
   Within the US public sector, Basil brings previous experience from the
   design of an authorized, secure, high-performance cloud architecture for
   Federal civilian agencies and contractors.

-  **Cody Bunch**, Rackspace

   Cody Bunch is a Private Cloud architect with Rackspace. Cody has
   co-authored an update to "The OpenStack Cookbook" as well as books on
   VMware automation.

-  **Malini Bhandaru**, Intel

   Malini Bhandaru is a security architect at Intel. She has a varied
   background, having worked on platform power and performance at Intel,
   speech products at Nuance, remote monitoring and management at ComBrio,
   and web commerce at Verizon. She has a Ph.D. in Artificial Intelligence
   from the University of Massachusetts, Amherst.

-  **Gregg Tally**, Johns Hopkins University Applied Physics Laboratory

   Gregg Tally is the Chief Engineer at JHU/APL's Cyber Systems Group within
   the Asymmetric Operations Department. He works primarily in systems
   security engineering. Previously, he has worked at SPARTA, McAfee, and
   Trusted Information Systems where he was involved in cyber security research
   projects.

-  **Eric Lopez**, VMware

   Eric Lopez is Senior Solution Architect at VMware's Networking and Security
   Business Unit where he helps customers implement OpenStack and VMware NSX
   (formerly known as Nicira's Network Virtualization Platform). Prior to
   joining VMware (through the company's acquisition of Nicira), he worked for
   Q1 Labs, Symantec, Vontu, and Brightmail.  He has a B.S in Electrical
   Engineering/Computer Science and Nuclear Engineering from U.C. Berkeley and
   MBA from the University of San Francisco.

-  **Shawn Wells**, Red Hat

   Shawn Wells is the Director, Innovation Programs at Red Hat, focused on
   improving the process of adopting, contributing to, and managing open source
   technologies within the U.S. Government. Additionally, Shawn is an upstream
   maintainer of the SCAP Security Guide project which forms virtualization and
   operating system hardening policy with the U.S. Military, NSA, and DISA.
   Formerly aa NSA civilian, Shawn developed SIGINT collection systems
   utilizing large distributed computing infrastructures.

-  **Ben de Bont**, HP

   Ben de Bont is the CSO for HP Cloud Services. Prior to his current role Ben
   led the information security group at MySpace and the incident response team
   at MSN Security. Ben holds a master's degree in Computer Science from the
   Queensland University of Technology.

-  **Nathanael Burton**, National Security Agency

   Nathanael Burton is a Computer Scientist at the National Security Agency. He
   has worked for the Agency for over 10 years working on distributed systems,
   large-scale hosting, open source initiatives, operating systems, security,
   storage, and virtualization technology.  He has a B.S. in Computer Science
   from Virginia Tech.

-  **Vibha Fauver**

   Vibha Fauver, GWEB, CISSP, PMP, has over fifteen years of experience in
   Information Technology. Her areas of specialization include software
   engineering, project management and information security.  She has a B.S. in
   Computer & Information Science and a M.S. in Engineering Management with
   specialization and a certificate in Systems Engineering.

-  **Eric Windisch**, Cloudscaling

   Eric Windisch is a Principal Engineer at Cloudscaling where he has been
   contributing to OpenStack for over two years. Eric has been in the trenches
   of hostile environments, building tenant isolation and infrastructure
   security through more than a decade of experience in the web hosting
   industry. He has been building cloud computing infrastructure and automation
   since 2007.

-  **Andrew Hay**, CloudPassage

   Andrew Hay is the Director of Applied Security Research at CloudPassage,
   Inc. where he leads the security research efforts for the company and its
   server security products purpose-built for dynamic public, private, and
   hybrid cloud hosting environments.

-  **Adam Hyde**

   Adam facilitated this Book Sprint. He also founded the Book Sprint
   methodology and is the most experienced Book Sprint facilitator around.
   Adam founded FLOSS Manuals—a community of some 3,000 individuals
   developing Free Manuals about Free Software. He is also the founder and
   project manager for Booktype, an open source project for writing, editing,
   and publishing books online and in print.

During the sprint we also had help from Anne Gentle, Warren Wang, Paul
McMillan, Brian Schott and Lorin Hochstein.

This Book was produced in a 5 day book sprint. A book sprint is an intensely
collaborative, facilitated process which brings together a group to produce a
book in 3-5 days. It is a strongly facilitated process with a specific
methodology founded and developed by Adam Hyde.  For more information visit the
book sprint web page at http://www.booksprints.net.

How to contribute to this book
------------------------------

The initial work on this book was conducted in an overly air-conditioned room
that served as our group office for the entirety of the documentation sprint.

Learn more about how to contribute to the OpenStack docs:
http://wiki.openstack.org/Documentation/HowTo.
