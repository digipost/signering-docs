.. _signature-type:

Signature type
*************

In Norway, we have three different types of digital signature, as described in the Norwegian Electronic Signature Act: authenticated, advanced and qualified. Standard signature is a strong signature, advanced signature is even stronger and qualified signature is the strongest signature.

We offer standard and advanced signature, which are legally valid signatures on a par with a handwritten signature. Qualified signature does not currently exist, but is intended to be achieved in the longer term via the National ID card.

..  _advanced-signature:

Advanced signature
==================

On using advanced signature, signing takes place using BankID. This provides a strong link between the verification of identity action and the documents to be signed.

An advanced signature has a stronger connection between the signature and the documents than an :ref:`authenticated-signature`, because only BankID is involved in the process.

..  TIP::
    Signing can take place using BankID, Buypass or BankID mobile phone. [#footnoteSigneringsmetoderOffentlig]_

..  _authenticated-signature:

Authenticated signature
=====================

On using authenticated signature, the user's identity is verified in the ID portal. The ID portal does not know that the login is connected to a signing ceremony and it is Signicat's job to link the verification of identity and the documents to a signature.

An authenticated signature is a little weaker than an advanced signature because several parties are involved and it takes place in two stages.

The sender can select :ref:`security-level` on the signing.

Signature type selection
=====================

..  tabs::

    ..  tab:: Private organization

        As a private organization, you can only select advanced signature and therefore do not need to set this explicitly.

    ..  tab:: Public organization

        As a public organization, you can choose between :ref:`advanced-signature` and :ref:`authenticated-signature`. The Norwegian Digitalisation Agency recommends public organizations to use authenticated signature because it is less expensive, but still fulfils the requirements made in the public sector.

        ..  NOTE::
            The default value for signature type is authenticated.

.. rubric:: Footnotes

.. [#footnoteSigneringsmetoderOffentlig] BankID mobile phone is not available for advanced signing tasks from public organizations.
