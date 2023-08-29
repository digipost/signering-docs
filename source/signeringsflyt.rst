
.. _signature-flow:

Signature flow
*******************

A signature request contains the documents to be signed and can be addressed to one or more signers for signing. The service mainly offers two different types of signature flow.

.. _signing-in-direct-flow:

Signing in direct flow
========================

Signing in direct flow takes place when the signer is already logged into the sender's system. This flow is ideal if the sender wants the end-user to experience the signing process as an integral part of their website.

The flow typically looks like this:

#. The signer is logged into the sender's service and performs a process for which e.g. filling in a form is the end result
#. The sender creates a signature request in the digital signature service via the API
#. The signer is sent to the digital signature service and completes the signing
#. The signer is sent back to the sender's service
#. The sender downloads the signature and offers a copy of the signed document to the signer

..  TIP::
    Please refer to `this graphic guide in Google Presentation for signing in direct flow <https://docs.google.com/presentation/d/14Q_-YzaxcGsZOgUR6rJl7rWSwLZwujnuqgkKCrxksoA/edit#slide=id.g3922592cb8_0_0>`_.

.. _signing-in-portal-flow:

Signering i portalflyt
========================

.. _signing-in-portal-flow-with-national-identity:

Address using national identity number
________________________________________

If you use a national identity number as the address, the signer will have to log into the signature portal in order to view the signing task.

The flow typically looks like this:

#. The sender creates a signature request via API or online in the sender portal
#. Posten signering notifies the signer by email (and, if applicable, SMS if specificed upon registration)
#. The signer logs into the signature portal and holds the signing ceremony
#. The signer downloads a signed document
#. The signer logs out of the signature portal
#. The sender downloads the signed document

..  TIP::
    Please see `this graphic guide in Google Presentation for signing in portal flow, addressing with national identity number <https://docs.google.com/presentation/d/14Q_-YzaxcGsZOgUR6rJl7rWSwLZwujnuqgkKCrxksoA/edit#slide=id.g36b93b9965_0_57>`_.

.. _signing-in-portal-flow-without-national-identity:


Address using e-mail / SMS
_______________________________

.. NOTE::
   This option is only available for private organizations

A signature flow whereby signers can access the signature portal via a link and a one-time code that is sent by email and/or SMS.

#. The sender creates a signature request via API or online in the sender portal
#. The signer receives a unique link and one-time code for the task by email or SMS
#. The signer clicks on the link and enters the one-time code for the request
#. The signer conducts the signing ceremony
#. End page from which the signed document can be downloaded

On addressing a signer without a national identity number, it is the sender’s responsibility to check that the right or desired person signs the document.

..  TIP::
    Please see `this graphic guide in Google Presentation for signing in portal flow, addressing with e-mail / SMS <https://docs.google.com/presentation/d/14Q_-YzaxcGsZOgUR6rJl7rWSwLZwujnuqgkKCrxksoA/edit#slide=id.g2e3b4edaeb_0_1>`_.
