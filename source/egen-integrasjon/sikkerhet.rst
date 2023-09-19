Security
**********

The digital signature service uses two-way TLS to ensure the confidentiality and message integrity of the transport layer. The document package containing the documents to be signed is integrity-assured with ASiC-E.

Two-way TLS
=============

To use the APIs, you need an organization certificate. Concerning purchase of and more information about the organization certificate, see :ref:`purchase of an organization certificate <buyEnterpriseCertificate>`. Here, you will also find information about which of the certificates you have that must be used for our service.

See also `approved organization certificate in the public sector <https://www.regjeringen.no/no/dokumenter/kravspesifikasjon-for-pki-i-offentlig-se/id611085/>`__ and `certificate management in the public sector <http://begrep.difi.no/SikkerDigitalPost/1.2.0/sikkerhet/sertifikathandtering>`__ for more information about root and intermediate certificates.

Most HTTP clients have built-in support for two-way TLS. You can see examples of the implementation in `the client library written in C# <https://github.com/digipost/signature-api-client-dotnet/>`_ or `the client library written in Java <https://github.com/digipost/signature-api-client-java/>`_. The digital signature service only supports TLS 1.2 for two-way TLS.

You use your own certificate in ``keystore`` (for verification of your identity), and add `the trust anchors (CA certificates) <http://begrep.difi.no/SikkerDigitalPost/1.2.0/sikkerhet/sertifikathandtering>`__ to the ``truststore`` (with which the server will verify its identity). Your certificate will be used for verification of your identity towards the server and the server will use Posten Bring AS' certificate to verify its identity. (Please note: During a transitional period following the change of name to Posten Bring AS on June 6th 2023, the subject of the certificate will remain as "Posten Norge AS", though this name is not used for validating the certificate.) Since the trust anchors are in the ``truststore`` you will obtain most of the validation from there (provided that your language/framework handles this). What you have to do manually is to validate that the certificate belongs to Posten Bring AS by checking the organization number stated in the ``Common Name``.

A good tip is to use or take inspiration from  `Difi's certificate validator <https://github.com/difi/certvalidator>`_.

Common problems when setting up two-way TLS
----------------------------------------------

-  The wrong ``truststore`` is used for the client. In the test environment, the ``truststore`` must contain the test certificates, and in production there must be production certificates.
-  The certificate used is not an organization certificate. Organization certificates are typically issued by Buypass or Commfides.
-  The client does not support TLS v1.2. Java 6 does not support TLS v1.2; in Java 7 this must be added explicitly.
-  The certificate is issued by Commfide’s SHA-1 root certificate. Only certificates with SHA-256 from Commfides are supported. This primarily applies to older certificates.

Personal data
------------------

Personal data and sensitive personal data are only to be entered in the following fields in the XML in the requests towards the API:

-  ``personal-identification-number`` – signer’s national identity number or D number
-  ``title`` – the title/topic of the request, which summarizes what the signature request concerns
-  ``description`` – may contain a personal message, additional information or a description of the documents

Other fields may not contain sensitive personal data or personal data. For example, the reference (``reference``) will be used outside a secure context (e.g. in email notifications) and therefore may not contain personal data. See also the description of the API below.

For further details of the terms personal data and sensitive personal data see the website of the `Norwegian Data Protection Authority <https://www.datatilsynet.no/personvern/personopplysninger/>`_.
