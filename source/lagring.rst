Storage
*********

.. _web-interface: https://signering.posten.no/virksomhet/#/logginn

As a general rule, signed documents are available for download/retrieval for 40 days after signing. After this, they are **deleted and are no longer available from the digital signature service**.

It is important to note that the value of digital signatures as evidence becomes weaker over time. This is because the technology that seals signed documents becomes obsolete as new technology is developed. We recommend that documents required to be used as evidence beyond 3 years undergo technical maintenance to protect their long-term value as evidence.

To ensure long-term value as evidence and safe storage of signed documents, we offer the optional *Long-term validation and storage service*.

.. _long-term-validation-and-storage:

Long-term validation and storage
================================

By activating *Long-term validation and storage*, Posten takes responsibility for ensuring that your signed documents have value as evidence and validity in the future. The documents will be stored for 20 years (50 years for documents signed before 12.04.2024) or for as long as the service exists. This value-added service is activated in the organization settings in the web-interface_ and costs NOK 4 per document.

How do we ensure long-term validation?
______________________________________
Long-term validation (LTV) documents the status of the signed document at the time of signing. The signed PDF document (PAdES) for all requests signed during the period in which *Long-term validation and storage* is activated is immediately flagged for technical preservation.

Documents that are flagged for long-term validation undergo technical preservation every 3 years (the time runs from the date of signing), which updates the cryptography and reinforces the sealing, to ensure that the signed document has not changed after the signature date.

What happens to the documents if I deactivate the service?
__________________________________________________________
All documents that were signed during the period in which *Long-term validation and storage* was activated will remain stored, have long-term value as evidence and be validated for as long as the service exists.

How do I get hold of preserved documents?
_____________________________________________
Long-term stored documents can be downloaded in the web interface or retrieved via the REST interface for API integrators in the same way as all other signed documents. See code examples for retrieval of signed documents in :ref:`signing-in-portal-flow` and :ref:`signing-in-direct-flow`.

Deleting documents
=======================
Senders can delete documents of *completed* signature-job if they want to remove them before being automatically purged according to the storage plan (default short-term 40 days, or long-term storage).
For jobs which are not completed, documents are automatically purged from storage shortly after they have been expired according to each job's specified deadline.


.. _storage-delete-limitations:

Limitations
_____________

- All signers must have signed before the documents can be deleted. Documents that have not been signed by all signers will be deleted automatically after 40 days and cannot be deleted manually by the sender.
- Documents may be deleted at the **earliest 24 hours after the instant the job was completed**, i.e. signed by the last signer, as signers must be able to download the document for a 24-hour period.
- Documents that are to be sent to the signer's digital mailbox cannot be deleted until they have been sent there. If the signer does not have a digital mailbox, it is necessary to wait for up to 7 days until the documents can be deleted.
