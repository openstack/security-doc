<Project Name> Architecture
===========================

**Contacts**:

- PTL: <name> - <irc handle>

- Architect: <name> - <irc handle>

- Security Reviewer: <name> - <irc handle>

Project Description and Purpose
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<Brief description of the purpose of the project; about a paragraph, can be cut/paste from wiki or other documentation. Include links to relevant presentations if available. Remove this comment>.


Primary Users
~~~~~~~~~~~~~

<Short statement about the expected primary users of the implemented
architecture. Remove this comment>.


Differences from Previous Architecture
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


<If this is a revision of a prior architecture, briefly list the new
components and interfaces>
<If this is a new architecture that replaces a prior service, briefly
describe how this service differs from its ancestor>
<If this is an entirely new service with no precedent, then state only
"This is a new service with no related prior solution".>


Components
~~~~~~~~~~

In the component descriptions that follow, I-C means they reside in
hosted instances on the cloud, and U-C means they are in the under
cloud infrastructure.

- <component-1 (I-C or U-C): <Describe component>

- <component-2 (I-C): <Describe component>

- <component-3 (U-C): <Describe component>


Data
~~~~

The following is the description of data types used by this service.
<See the <TODO> Information Classification Handling Policy for an
explanation of requirements associated with the Confidentiality and
Availability labels. Remove this comment>

.. csv-table::
   :header: "Data name","Confidentiality","Integrity","Availability","Description"


   "System request","Confidential","High","Medium","Requests between OpenStack services"
   "System reply","Confidential","High","Medium","Replies to System requests"
   "Data type X","Confidential","High","High","Data in motion, not stored"
   "Data type Y","Confidential","High","Medium","Parameters in config file."
   "MySQL database","Confidential","High","High","Contains user preferences. Backup to Swift daily."


Service Architecture Diagram
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

<Insert Service Architecture diagram here. For diagram requirements see
Architecture Diagram Requirements. Remove this comment>


Interfaces
~~~~~~~~~~
.. csv-table::
   :header: "Interface","Network name","Network protocol","Requestor","Request","Request credentials","Request authorization","Listener","Response","Response credentials","Description of operation"

   "1"
   "2"
   "3"

Guidance:

- Enter a component name in the Requestor and Listener columns.

- Enter a data name in the Request and Response columns.  If a request
uses unidirectional TLS authentication (which means that the client
authenticates the server but the server does NOT authenticate the
client) then TLS should not be listed in the "Request credentials"
cell for the interface.  If a request uses bidirectional TLS
authentication (which means that the server authenticates the client
and the client authenticates the server) then it may be appropriate to
list "TLS Certificate" in the "Request  credentials" cell for the
interface but normally this is not the case.  The following examples
attempt to clarify this for common situations:

Over an HTTPS session a service sends a Keystone token to authenticate
itself.  In this case the Request credential is the Keystone token and
the Network protocol is HTTPS.
A service connects to a database using SQL with a username and password.
Customers have the option at installation time to set up TLS for this
connection but are not required to do so.  In this case list the most
secure available option in the interfaces table: the Network protocol is
"SQL with TLS" and the Request credentials are "username/password"
Do not use an interface to show a function call within the same process.
It is appropriate to show calls or effects which a process or library
makes outside of the process.  For example, if the project is
responsible for part of a process, such as a library, do not list
intra-process calls to that library as separate interfaces.  On the
service architecture diagram you can show the process and the library
and color-code them to show the part(s) for which the project has
responsibility, like this:
