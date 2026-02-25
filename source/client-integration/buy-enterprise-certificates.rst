.. _buyEnterpriseCertificate:

Buy enterprise certificates
***************************

As a sending organization, you must authenticate with an enterprise certificate (virksomhetssertifikat) issued by either Buypass or Commfides. You will need a test certificate and a production certificate. These must be in the RSA format.

Test environment
###########################

A test certificate must be used against our test environment. The test certificate will be used in the testing phase, and as soon as you are ready to deploy your integration to production, you will have to replace it with a production certificate.

.. NOTE::
   It is not possible to use a test certificate in production or the other way around.

.. tabs::

   .. group-tab:: Buypass

    A test certificate can be bought from Buypass, on either their `Norwegian <https://www.buypass.no>`__ or `English <https://www.buypass.com>`__ site. Look for "Virksomhetssertifikat" (no) or "Enterprise certificate" (en), and there should be options for both ordering new ones, or renewing previously bought certificates. If given a choice, please select *Standard sertifikat/Standard Certificate*.

    When buying an enterprise certificate from Buypass, you will receive two emails. You should only use the certificate from the email that includes the *private key*. This is the email that contains two *.p12* files. The two files have different serial numbers, and these refer to certificates used for authentication and encryption (*autentisering og kryptering*) and signature (*signering*). Only the certificate marked for authentication and encryption is applicable to use for integrating with the Posten signering API.

   .. group-tab:: Commfides

    A test certificates can be bought from Commfides, on either their `Norwegian <https://www.commfides.com/en/commfides-virksomhetssertifikat/>`__ or `English <https://www.commfides.com/en/commfides-virksomhetssertifikat/>`__ site. Please see *Bestill Testsertifikat/Order Test Certificate*.

    When buying an enterprise certificate from Commfides, you will receive an email containing three *.p12* files: *auth*, *enc* and *sign*. You shall use the one named *auth* with :code:`Key Usage = Digital Signature`.



Production environment
###########################

.. DANGER::
   Both the production enterprise certificate and the password must be stored securely. Do not under any circumstances send the file or the password to anyone.

.. tabs::

   .. group-tab:: Buypass

    A production certificate can be bought from Buypass, on either their `Norwegian <https://www.buypass.no>`__ or `English <https://www.buypass.com>`__ site. Look for "Virksomhetssertifikat" (no) or "Enterprise certificate" (en), and there should be options for both ordering new ones, or renewing previously bought certificates. If given a choice, please select *Standard sertifikat/Standard Certificate*.

    When buying an enterprise certificate from Buypass, you will receive two emails. You should only use the certificate from the email that includes the *private key*. This is the email that contains two *.p12* files. The two files have different serial numbers, and these refer to certificates used for authentication and encryption (*autentisering og kryptering*) and signature (*signering*). Only the certificate marked for authentication and encryption is applicable to use for integrating with the Posten signering API.

   .. group-tab:: Commfides

    A production certificate can be bought from Commfides, on either their `Norwegian <https://www.commfides.com/en/commfides-virksomhetssertifikat/>`__ or `English <https://www.commfides.com/en/commfides-virksomhetssertifikat/>`__ site. Please see *Bestill Virksomhetssertifikat/Order Enterprise Certificate* for use in a production environment.

    When buying an enterprise certificate from Commfides, you will receive an email containing three *.p12* files: *auth*, *enc* and *sign*. You shall use the one named *auth* with :code:`Key Usage = Digital Signature`.
