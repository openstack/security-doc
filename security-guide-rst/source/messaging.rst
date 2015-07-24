===============
Message queuing
===============

Message queuing services facilitate inter-process communication in
OpenStack. OpenStack supports these message queuing service back ends:

-  RabbitMQ

-  Qpid

-  ZeroMQ or 0MQ

Both RabbitMQ and Qpid are Advanced Message Queuing Protocol (AMQP)
frameworks, which provide message queues for peer-to-peer communication.
Queue implementations are typically deployed as a centralized or
decentralized pool of queue servers. ZeroMQ provides direct peer-to-peer
communication through TCP sockets.

Message queues effectively facilitate command and control functions
across OpenStack deployments. Once access to the queue is permitted no
further authorization checks are performed. Services accessible through
the queue do validate the contexts and tokens within the actual message
payload. However, you must note the expiration date of the token because
tokens are potentially re-playable and can authorize other services in
the infrastructure.

OpenStack does not support message-level confidence, such as message
signing. Consequently, you must secure and authenticate the message
transport itself. For high-availability (HA) configurations, you must
perform queue-to-queue authentication and encryption.

With ZeroMQ messaging, IPC sockets are used on individual machines.
Because these sockets are vulnerable to attack, ensure that the cloud
operator has secured them.

.. toctree::
   :maxdepth: 2

   messaging/security.rst
   messaging/case-studies.rst
