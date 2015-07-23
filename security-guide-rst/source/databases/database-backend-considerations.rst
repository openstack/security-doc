================================
Database back end considerations
================================

PostgreSQL has a number of desirable security features such as Kerberos
authentication, object-level security, and encryption support. The
PostgreSQL community has done well to provide solid guidance,
documentation, and tooling to promote positive security practices.

MySQL has a large community, widespread adoption, and provides high
availability options. MySQL also has the ability to provide enhanced
client authentication by way of plug-in authentication mechanisms.
Forked distributions in the MySQL community provide many options for
consideration. It is important to choose a specific implementation of
MySQL based on a thorough evaluation of the security posture and the
level of support provided for the given distribution.

Security references for database back ends
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Those deploying MySQL or PostgreSQL are advised to refer to existing
security guidance. Some references are listed below:

MySQL:

-  `OWASP MySQL
   Hardening <https://www.owasp.org/index.php/OWASP_Backend_Security_Project_MySQL_Hardening>`__

-  `MySQL Pluggable
   Authentication <http://dev.mysql.com/doc/refman/5.5/en/pluggable-authentication.html>`__

-  `Security in
   MySQL <http://downloads.mysql.com/docs/mysql-security-excerpt-5.1-en.pdf>`__

PostgreSQL:

-  `OWASP PostgreSQL
   Hardening <https://www.owasp.org/index.php/OWASP_Backend_Security_Project_PostgreSQL_Hardening>`__

-  `Total security in a PostgreSQL
   database <http://www.ibm.com/developerworks/opensource/library/os-postgresecurity>`__
