Create signature request
===========================

On creating signature requests, the following fields can be specified:

+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Field                     | Direct flow                | Portal flow       | Extra information                                             |
+===========================+============================+===================+===============================================================+
| Documents                 | **Mandatory**              | **Mandatory**     | 1-20 documents [#f4]_                                         |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Signer(s)                 | **Mandatory**              | **Mandatory**     | see :ref:`addressing-signers`                                 |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Title                     | **Mandatory**              | **Mandatory**     | Maximum 80 characters [#f1]_                                  |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Non-sensitive title       | Not applicable             | Optional          | Maximum 80 characters [#f1]_                                  |
| / Description             |                            |                   |                                                               |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Signature type            | Optional                   | Optional          | see :ref:`signature-type`                                     |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Security level            | Optional                   | Optional          | see :ref:`security-level`                                     |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Message to receiver(s)    | Optional                   | Optional          | Maximum 220 characters [#f1]_                                 |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Signer identifier         | Optional                   | Optional          | see :ref:`addressing-signers`                                 |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Activation time           | Cannot be overrided [#f2]_ | Optional          |                                                               |
+---------------------------+-------------------------+----------------------+---------------------------------------------------------------+
| Lifetime                  | Cannot be overrided [#f3]_ | Optional          |                                                               |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| E-mail address            | Not applicable             | **Mandatory**     | see :ref:`notifications`                                      |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Mobile number             | Not applicable             | Optional          | see :ref:`notifications`                                      |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+
| Sequence                  | Not applicable             | Optional          | see :ref:`chained-signing`                                    |
+---------------------------+----------------------------+-------------------+---------------------------------------------------------------+

.. rubric:: Footnotes

.. [#f1] The maximum number of characters permitted is valid in both `direct <https://github.com/digipost/signature-api-specification/blob/2.7/schema/xsd/direct.xsd#L68-L75>`_ and `portal flow <https://github.com/digipost/signature-api-specification/blob/2.7/schema/xsd/portal.xsd#L98-L105>`_.
.. [#f2] Signature requests in direct flow are always activated immediately after creation. *The default value* is *immediately after creation*.
.. [#f3] Signature requests in direct flow always have a 30-day lifespan, to avoid a document being signed far too long after the creation of the task. Any deadline from the sender’s perspective must be communicated and handled in the sender’s services.
.. [#f4] Multiple documents are not supported for advanced signature from public organizations

For implementation of signature requests in portal flow, see  :ref:`portal-flow`, and for signature requests in direct flow, see :ref:`direct-flow`.

Limitations
______________

Number of signers
^^^^^^^^^^^^^^^^^

A signature request may have several signers. The service allows a maximum of ten signers per request.

Speed
^^^^^

The service permits a maximum of 10 API calls per second per organization number. If a sender exceeds this limit, the API will return :code:`HTTP 429 Too Many Requests`, and the sender will be blocked for 30 seconds.


..  _document-format:

Document format
^^^^^^^^^^^^^^^^^

The service supports PDF (:code:`.pdf`). documents. Both PDF and PDF/A are by the service. The signed document will be of the same type as the original documents. One or more original documents that are PDF/A give a signed PAdES document that is PDF/A, and one or more original documents that are PDF version 1.1-1.7 give a signed PAdES document that is PDF version 1.7. If the original documents contain both PDF and PDF/A, the signed document will be of the PDF version 1.7 type. For PDF/A, the service will always produce signed PAdES documents of the PDF/A-3b type, irrespective of the PDF/A version and conformity level of the original documents.

For archiving of signed documents, we recommend using original PDF/A documents. This is a requirement if the signed document is to be submitted to the National Archives of Norway.

For testing, use the example documents :download:`PDF-1.2 <files/PDF-1-2-testdokument.pdf>`, :download:`PDF-1.3 <files/PDF-1-3-testdokument.pdf>`, :download:`PDF-1.4 <files/PDF-1-4-testdokument.pdf>`, :download:`PDF-1.5 <files/PDF-1-5-testdokument.pdf>`, :download:`PDF-1.6 <files/PDF-1-6-testdokument.pdf>` og :download:`PDF-A <files/PDF-A-testdokument.pdf>`.

..  NOTE::
    The documents can amount to maximum 10 MB (:code:`10 485 760 bytes`) in size. PDF versions supported are PDF 1.1-1.7.

In PAdES, the documents will always be presented in A4 and portrait format. For best results, it is recommended that the submitted documents are also in this format.

..  CAUTION::
    Password-protected documents (restricted reading and/or writing access) are not supported by the service.

Activation time
^^^^^^^^^^^^^^^^^^^^^^

Indicates the time when the signature request is to be made available to the signer(s). If the activation time is in the past, the reuqest will be available immediately after creation.

Signature requests in direct flow are always activated immediately after creation.

Lifetime of the request
^^^^^^^^^^^^^^^^^^^^^^^

Indicates for how long *after activation* a signature request is available to the signer before it expires. Can be maximum 90 days after activation.

Signature requests in direct flow always have a 30-day lifespan, to avoid documents being signed far too long time after the creation of the request. Any deadline from the sender’s perspective must be communicated and handled in the sender’s services.
