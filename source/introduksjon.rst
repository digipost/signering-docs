Why use Posten signering (Norway Post's digital signature service)
********************************************************************

We believe in making people’s lives easier. By using Posten signering, you can say goodbye to printing, scanning and sending documents back and forth.



What is Posten signering
########################

Posten signering is a digital signature service for public and private organizations. When documents are signed digitally, an electronic ID is used, and the signed document cannot subsequently be changed without invalidating the signature. The signed document can be downloaded, or kept in the organization's own archive in Posten signering. The service supports both several persons signing the same document, as well as signing multiple documents at once. We are constantly improving the service, and are happy to receive feedback.


How to use Posten signering
###########################

As an organization, you can use Posten signering in two ways, depending on your needs and the desired signature flow:

Sender portal
-------------
The sender portal enables an organization to use Posten signering by sending documents directly from the browser. The documents are uploaded manually to our web portal. Signers then read and sign documents via :ref:`portal-flow <portal-flow>`. This is a simple and effective way of getting started with the service and is suitable for smaller volumes. If you work in a private organization, you can `register the business directly <https://signering.posten.no/registrering/bedrift>`_ and start sending documents right away. If you work in a public organization, you must register your account via `Digitaliseringsdirektoratet og samarbeidsportalen <https://samarbeid.digdir.no/esignering/ta-i-bruk-esignering/104>`_.

API integration
---------------
The API interface requires technical integration between the organization and Posten signering. By creating an integration with the service, the signer will access the organization's website, and the digital signature service will be experienced as an integral part of the service. You can choose whether the signer is to sign in your organization's system or website (:ref:`direct-flow <direct-flow>`), or to allow the signer to sign in the Posten signature portal (:ref:`portal-flow <portal-flow>`).

Integration with the API can be done in three ways
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. :doc:`Use of client libraries <client-integration/buy-enterprise-certificates>`:
We provide client libraries that simplify the integration process for customers wishing to integrate the signature service into their own systems. The client libraries support the Java and .NET programming languages.

2. Integration via software product or partner:
Many customers use a professional system as their case and archive systems, or other software products as the source of documents to be signed.

3. :doc:`Self-developed integration <egen-integrasjon/dokumentpakke>`:
The API is documented so that customers can make their own integration if they want to.

..  NOTE::
    Private organizations must contact us at salg@digipost.no to gain access to the API, after `registering <https://signering.posten.no/registrering/bedrift>`_ the organization.
