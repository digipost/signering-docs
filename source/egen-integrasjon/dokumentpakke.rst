.. _information-about-document-package:

Document package
****************

The document package in Posten signering is based on the ASiC-E standard (`Associated Signature Containers, Extended form <http://www.etsi.org/deliver/etsi_ts/102900_102999/102918/01.03.01_60/ts_102918v010301p.pdf>`_). The profile is designed to be similar to that used for `Digital mailbox to residents <https://docs.digdir.no/resources/begrep/sikkerDigitalPost/forretningslag/Dokumentpakke/>`_. Read more about the :ref:`profile used for ASiC <asicEStandards>` at the end of this document.


Contents
========

The package is in ZIP format and contains:

- the document to be signed (a PDF or plain text file)
- the file ``manifest.xml`` which describes metadata for the document (subjects, who must sign, etc.)
- the file ``META-INF/signatures.xml`` which is the signature for the entire document package.

Document
--------

For information about document restrictions, see :ref:`document-format`. This file is referenced with the required ``href``-attribute i n``document`` element in ``manifest.xml``. See examples for `signature requests in direct flow <https://github.com/digipost/signature-api-specification/blob/master/schema/examples/direct/manifest.xml#L10>`_ and `signature requests in portal flow <https://github.com/digipost/signature-api-specification/blob/master/schema/examples/portal/manifest.xml#L34>`_.

.. _manifestxml:

Manifest
----------------

The file ``manifest.xml`` follows the schema `direct-and-portal.xsd <https://github.com/digipost/signature-api-specification/blob/master/schema/xsd/direct-and-portal.xsd>`_, which again imports `direct.xsd <https://github.com/digipost/signature-api-specification/blob/master/schema/xsd/direct.xsd>`_ and `portal.xsd <https://github.com/digipost/signature-api-specification/blob/master/schema/xsd/portal.xsd>`_.

See how to create requests in :ref:`direct flow <directIntegrationStep1>` and :ref:`portal flow <portalIntegrationStep1>` for examples of different ways in which the elements can be built up.

.. _signaturesxml:

Signatures
------------------

The file ``signatures.xml`` follows the schema ``http://uri.etsi.org/2918/v1.2.1#``. See `Thirdparty (catalogue) <https://github.com/digipost/signature-api-specification/tree/master/schema/xsd/thirdparty>`_ for copies of the relevant standard schemas.

Examples of complete ``signatures.xml``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: xml

   <?xml version="1.0" encoding="UTF-8" standalone="no"?>
   <XAdESSignatures xmlns="http://uri.etsi.org/2918/v1.2.1#">
       <Signature xmlns="http://www.w3.org/2000/09/xmldsig#" Id="Signature">
           <SignedInfo>
               <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
               <SignatureMethod Algorithm="http://www.w3.org/2001/04/xmldsig-more#rsa-sha256"/>
               <Reference Id="ID_0" URI="document.pdf">
                   <DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
                   <DigestValue>LPJNul+wow4m6DsqxbninhsWHlwfp0JecwQzYpOLmCQ=</DigestValue>
               </Reference>
               <Reference Id="ID_1" URI="manifest.xml">
                   <DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
                   <DigestValue>xTqm6xkL7NOjnf5oYa+m0+XKzq1cwWMkcoESLa+/Lko=</DigestValue>
               </Reference>
               <Reference Type="http://uri.etsi.org/01903#SignedProperties" URI="#SignedProperties">
                   <Transforms>
                       <Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"/>
                   </Transforms>
                   <DigestMethod Algorithm="http://www.w3.org/2001/04/xmlenc#sha256"/>
                   <DigestValue>cV6hPhJ6f8hnl0J9czhubj08rWhJmzCQsomxODfYyYM=</DigestValue>
               </Reference>
           </SignedInfo>
           <SignatureValue>VTc0CBKyuDD0DRsJx7JJf6c2iH+TndFcx1aj0nP99snV6magufrPR8JSYadWIn4QICpHFcpAp5s+
               XgIY9jfkAVLtAbiko9VcRpSopP1zj6tM3lrSaoo/lBKP0rWNZCQiNgw8f3pkGbi1bUKVwhbRI4XF
               +bc2rZiZoaWgOByhsFZ25hWrl+GgC3PNsEzA+WN3JbGAq00xtKudRG1vMjdjfsGtmvFYVQ0xQlUY
               5Vxdfovoia3x6zm5zbHWRQdVoUTS3vv5Mv6GAs7JAnDwSNxRVSizN5QB6xB60xRn+BFwdVedQTMa
               cuReWIxY2r8yocS9MAZxFG+4SAHGxjJkNkglHg==
           </SignatureValue>
           <KeyInfo>
               <X509Data>
                   <X509Certificate>MIIDYzCCAkugAwIBAgIEIyZ/HzANBgkqhkiG9w0BAQsFADBiMQswCQYDVQQGEwJOTzELMAkGA1UE
                       CBMCTk8xDTALBgNVBAcTBE9zbG8xETAPBgNVBAoTCEF2c2VuZGVyMREwDwYDVQQLEwhBdnNlbmRl
                       cjERMA8GA1UEAxMIQXZzZW5kZXIwHhcNMTQwNTIwMTIxMDA3WhcNMTUwNTE1MTIxMDA3WjBiMQsw
                       CQYDVQQGEwJOTzELMAkGA1UECBMCTk8xDTALBgNVBAcTBE9zbG8xETAPBgNVBAoTCEF2c2VuZGVy
                       MREwDwYDVQQLEwhBdnNlbmRlcjERMA8GA1UEAxMIQXZzZW5kZXIwggEiMA0GCSqGSIb3DQEBAQUA
                       A4IBDwAwggEKAoIBAQCOq505/fn9fDCZjvMlSWJNEj0kVLeFo233MEfhOUOhU44Q7ClGLJfEIdMr
                       ZCzWR58Eo8Fn90bEIosI8rCvw8XsNaDaeVgZ3PDtXTuA8luL/IphWXfuHxdmFm3LPD0XIQS+V8pg
                       J215NIScrZGkgBKjb7uVo+usGYUpqkbjl5kctTziRZo0k2i73iJd1+DjPGZ2OzAR1lMb8EEWheiX
                       qE+pRwpHQOkMiRlNrZxDD1mTJR2RLYYp/guW93YbIgJv4mhV3ZpJL8idU2YECkM5p6Wg2wfznCyx
                       ZU0E5Us4SvuDPrg48ELe140AtXQb8xyuGrLhCm5JyHhAFJM0IoiGQwqPAgMBAAGjITAfMB0GA1Ud
                       DgQWBBSpQuhFDLFSUauhNrCbx+g8QXv9oTANBgkqhkiG9w0BAQsFAAOCAQEAHAENC+ZsxNSXOb6D
                       e90uHqkEJFFZF3CfdtRHx23s2wjDFJI4CEY8WHsOD90ynOyDZV/sWcu1Emi1nZ7rEdtt/wKfhIdI
                       CBzZ+GkU04niu+jpM9OCk1JS1LU+e+ljz6ZL7OZVegTE6tLI8JwfInf7dBjSBnf69Gs4xRK/TmO5
                       i5KipdivkTGXJCaLf8lwFM3bxM5t0H8AzbrHc0JVVTTXHjbIvgg7JhFuiC1z1vM6hsplOysb9gFP
                       89AvNttWcdSb0rQAVz0rjl+GKzM07Aw4tYBl8j42POtjMCjV5e0TCeNfLfnZ3r9DCSUNlAwhisoX
                       l5gXsb+YU/RPOlg+xh5xRA==
                   </X509Certificate>
               </X509Data>
           </KeyInfo>
           <Object>
               <QualifyingProperties xmlns="http://uri.etsi.org/01903/v1.3.2#"
                                     xmlns:ns2="http://www.w3.org/2000/09/xmldsig#" Target="#Signature">
                   <SignedProperties Id="SignedProperties">
                       <SignedSignatureProperties>
                           <SigningTime>2015-11-25T15:45:42.115+01:00</SigningTime>
                           <SigningCertificate>
                               <Cert>
                                   <CertDigest>
                                       <ns2:DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"/>
                                       <ns2:DigestValue>6Gko40cr8upGenUAxIT6bBVcRfo=</ns2:DigestValue>
                                   </CertDigest>
                                   <IssuerSerial>
                                       <ns2:X509IssuerName>CN=Avsender, OU=Avsender, O=Avsender, L=Oslo, ST=NO, C=NO</ns2:X509IssuerName>
                                       <ns2:X509SerialNumber>589725471</ns2:X509SerialNumber>
                                   </IssuerSerial>
                               </Cert>
                           </SigningCertificate>
                       </SignedSignatureProperties>
                       <SignedDataObjectProperties>
                           <DataObjectFormat ObjectReference="#ID_0">
                               <MimeType>application/pdf</MimeType>
                           </DataObjectFormat>
                           <DataObjectFormat ObjectReference="#ID_1">
                               <MimeType>application/xml</MimeType>
                           </DataObjectFormat>
                       </SignedDataObjectProperties>
                   </SignedProperties>
               </QualifyingProperties>
           </Object>
       </Signature>
   </XAdESSignatures>


.. _asicEStandards:

Standards used in the document package
======================================

It must be possible to validate the integrity of documents and metadata in the digital signature service many years after receipt. This is ensured by packing the information in a document package protected with digital signatures, as described below. In practice, this is a zip file with a given structure that contains a digital signature of the contents.

Standards
------------

===================== ======================================================================================================= ==============
Standard              Document                                                                                                 Version
===================== ======================================================================================================= ==============
ETSI, ETSI TS 102 918 Electronic Signatures and Infrastructures (ESI); Associated Signature [#etsi1]_                          ETSI, 2013-06.
ETSI, ETSI TS 103 174 Electronic Signatures and Infrastructures (ESI); ASiC Baseline Profile [#etsi2]_                         ETSI, 2013-06.
ETSI, ETSI TS 101 903 Electronic Signatures and Infrastructures (ESI); XML Advanced Electronic Signatures (XAdES) [#etsi3]_    ETSI, 2010-12.
ETSI, ETSI TS 103 171 Electronic Signatures and Infrastructures (ESI); XAdES Baseline Profile [#etsi4]_                        ETSI, 2012-03.
===================== ======================================================================================================= ==============

ASiC profile for the document package
-------------------------------------

The document is packaged in a document package together with metadata in accordance with ASiC (ETSI TS 102 918) [#etsi1]_, and further limited according to the profile defined in Baseline Profile (ETSI TS 103 174) [#etsi2]_. Additional restrictions are as follows:

============================== ============================================================================================================================== =============================================================================================================================================================================================================================
Requirements                   Fields                                                                                                                         Comments
============================== ============================================================================================================================== =============================================================================================================================================================================================================================
requirement 6.1  [#etsi29]_    ASiC conformance                                                                                                               Should be “ASiC‑E XAdES”
requirement 8.1 [#etsi211]_    SiC‑E Media type identification                                                                                                Should be “ASiC file extension is”.asice
requirement 8.2 [#etsi211]_    SiC‑E Signed data object                                                                                                       All files outside of the META-INF catalogue shall be signed
requirement 8.3.1 [#etsi212]_  SiC‑E XAdES signature                                                                                                          There should only be one signature in the META-INF catalogue, with the name signatures.xml. This signature shall cover all other files in the container, and the sender's organization certificate shall be used for signing.
requirement 8.3.2 [#etsi212]_  equirements for the contents of Container” refererer til “6.2.2 punkt 4b) "META-INF/manifest.xml" if present […] i”ASiC":etsi1 This file should not be present
============================== ============================================================================================================================== =============================================================================================================================================================================================================================

Signature in the document package
---------------------------------

The document package should be signed by the “Data Controller”, but may be signed by the “Data Processor”.

The signature must be in accordance with XAdES (ETSI TS 101 903) [#etsi3]_ with the baseline profile defined in XAdES Baseline Profile (ETSI TS 103 171) [#etsi4]_ (B-Level Conformance). Additional restrictions are as follows:

============================= ============================================= ===================================================================================================================================================================================================================================================================================================================
Requirements                  Fields                                        Comments
============================= ============================================= ===================================================================================================================================================================================================================================================================================================================
requirement 5.1 [#etsi48]_    Algorithm requirements                        The signing algorithm should be `rsa-sha256 <http://www.w3.org/2001/04/xmldsig-more#rsa-sha256>`_. The finger print algorithm in the references should be `sha256 <http://www.w3.org/2001/04/xmlenc#sha256>`_. The finger print algorithm in CertDigest should be `sha1 <http://www.w3.org/2000/09/xmldsig#sha1>`_
requirement 6.2.1 [#etsi410]_ Placement of the signing certificate          All certificates from the organization certificate and up to and included a trusted root should be included
requirement 6.2.2 [#etsi411]_ Canonicalization of ds:SignedInfo element     Should be `xml-c14n11 <http://www.w3.org/2006/12/xml-c14n11>`_. Can be `REC-xml-c14n-20010315 <http://www.w3.org/TR/2001/REC-xml-c14n-20010315>`_
requirement 6.2.3 [#etsi411]_ Profile of ds:Reference element               All documents should be included, and references outside of the document package are not allowed
requirement 6.2.4 [#etsi412]_ Transforms within ds:Reference element        All file references should be without transform, and the reference to SignedProperties should be `REC-xml-c14n-20010315 <http://www.w3.org/TR/2001/REC-xml-c14n-20010315>`_
requirement 6.3.1 [#etsi412]_ Profile of xades:SigningCertificate element   No further limitations
requirement 6.3.2 [#etsi413]_ Profile of xades:SigningTime element          The time indication should be correct within the interval of +/- 5 seconds
requirement 6.3.3 [#etsi413]_ Profile of xades:DataObjectFormat element     Only MimeType and ObjectReference should be present
============================= ============================================= ===================================================================================================================================================================================================================================================================================================================

..  rubric:: Footnotes

.. [#etsi1] http://www.etsi.org/deliver/etsi_ts/102900_102999/102918/01.03.01_60/ts_102918v010301p.pdf
.. [#etsi2] http://www.etsi.org/deliver/etsi_ts/103100_103199/103174/02.02.01_60/ts_103174v020201p.pdf
.. [#etsi29] http://www.etsi.org/deliver/etsi_ts/103100_103199/103174/02.02.01_60/ts_103174v020201p.pdf#page=9
.. [#etsi211] http://www.etsi.org/deliver/etsi_ts/103100_103199/103174/02.02.01_60/ts_103174v020201p.pdf#page=11
.. [#etsi212] http://www.etsi.org/deliver/etsi_ts/103100_103199/103174/02.02.01_60/ts_103174v020201p.pdf#page=12
.. [#etsi3] http://www.etsi.org/deliver/etsi_ts%5C101900_101999%5C101903%5C01.04.02_60%5Cts_101903v010402p.pdf
.. [#etsi4] http://www.etsi.org/deliver/etsi_ts/103100_103199/103171/02.01.01_60/ts_103171v020101p.pdf
.. [#etsi48] http://www.etsi.org/deliver/etsi_ts/103100_103199/103171/02.01.01_60/ts_103171v020101p.pdf#page=8
.. [#etsi410] http://www.etsi.org/deliver/etsi_ts/103100_103199/103171/02.01.01_60/ts_103171v020101p.pdf#page=10
.. [#etsi411] http://www.etsi.org/deliver/etsi_ts/103100_103199/103171/02.01.01_60/ts_103171v020101p.pdf#page=11
.. [#etsi412] http://www.etsi.org/deliver/etsi_ts/103100_103199/103171/02.01.01_60/ts_103171v020101p.pdf#page=12
.. [#etsi413] http://www.etsi.org/deliver/etsi_ts/103100_103199/103171/02.01.01_60/ts_103171v020101p.pdf#page=13
