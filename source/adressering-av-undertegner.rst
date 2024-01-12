.. _addressing-signers:

Addressing signers
***************************
You may address signers for :ref:`portal flow <signing-in-portal-flow>` in two different ways:

1. By email and/or SMS (only available for private organizations)
2. By national identity number

The signed document will only include signatures from the *addressed* signers, so remember to include signers from the sender side as well, if applicable.

..  CAUTION::
    How you choose to address the signer(s) affects the :ref:`content and appearance of the signature(s) in the resulting signed document <identify-signers>`.

1. Addressing signers by e-mail / SMS
=====================================

.. NOTE::
   This option is only available for private organizations

When addressing signers by email/SMS, we will not be able to link signers to their national identity number. Therefore, we do not have any way to verify that the correct person is reading and signing. The signers receive an email and/or SMS with a unique code and link to access the document(s) to sign, instead of being required to log in. See :ref:`notifications <notifications-without-national-identity>` to review what the notifications look like.


..  IMPORTANT::
    The signature itself is just as secure and valid as when you address using national identity number, but you as the sender are responsible for ensuring that the correct person reads and signs.

In the case of e-mail/SMS addressing, the national identity number will not be included in the signed document for privacy reasons. Name and any date of birth will continue to be included in the signed document.

See :ref:`Signing in portal flow with addressing by e-mail / SMS <signing-in-portal-flow-without-national-identity>` for more information and visual examples.

2. Addressing signers by their national identity number
=======================================================
If you know the national identity numbers of the signers, you can address them using their identity numbers. This is the most secure way to reach the expected signers, since it requires them to log in with an electronic ID in order to read and sign.

Even if the signer is addressed using a national identity number, the signer will be notified and will receive a link to log in by email or SMS – see :ref:`notification and contact details <notifications>` for more information..


..  TIP::
    See :ref:`signing in portal flow with national identity number <signing-in-portal-flow-with-national-identity>` for more information and visual examples.


.. _notifications:


Notifications and contact details
---------------------------------

When you select signing in portal flow, emails and/or SMS notifications are sent to the signers.

 - All signers must have at least one email address and mobile number.
 - Sending an SMS is voluntary and can be ordered by the service owner, at a cost of NOK 40 cents per SMS.
 - If a signer has a mobile number and not an email address, an SMS will always be sent.

For private organizations
^^^^^^^^^^^^^^^^^^^^^^^^^
If the sender is a **private organization**, you must yourself enter the email address and/or mobile number of the recipient. This also applies if you address the signer using national identity number. Private organizations cannot use KRR.

For public organizations
^^^^^^^^^^^^^^^^^^^^^^^^^^^
For **public organizations**, we obtain the signer's email address and mobile phone number from the `Contact and Reservation Register (KRR) <http://eid.difi.no/nb/kontakt-og-reservasjonsregisteret>`_. Public organizations can only define their own contact details for a signer if the signer is to sign on behalf of an organization.

..  CAUTION::
    If signers have opted out of digital communication, the task will be rejected and subsequent retrieval of the status of the task will report an error with details of which signers have opted out. Signers with overridden contact details will not be checked for opt-out.


Using The common contact register
============================================

Further details concerning the use of `The common contact register <https://eid.difi.no/en/common-contact-register>`_. This is only applicable for public sector organizations.

On sending out subsequent notifications (either deferred activation due to chained signature, or reminders) a new lookup is made in the register to retrieve the latest updated contact details.

If the Lookup Service for The common contact register is unavailable when reminders are sent, the result of the lookup on creating the request will be used.

Opt-out concerning deferred initial notifications: In the scenario where the service owner has set a chained sequence for the signers, and the initial notification is to be sent to a signer who, in the period between creation of the request and sending the initial notification, has opted out of electronic communication, the entire request will fail.

Opt-out concerning reminders: If the end user has opted out after the request was created, but the request has already been activated, no reminders (email/text message) will be sent, but the request will not fail either until any expiry of the signing deadline.


How to use the register in test environments
--------------------------------------------

In test/staging environments it is not possible to use real national identities to sign documents. In order to test signature flows including looking up contact information in The common contact register and performing document signing, artificial test users must be used.

Information on obtaining artificial test users is described here, as well as a set of available "preset" users:
`docs.digdir.no/docs/Kontaktregisteret/krr_testbrukere <https://docs.digdir.no/docs/Kontaktregisteret/krr_testbrukere>`_.

For a lookup in the The common contact register to succeed, and enabling the signature job to proceed, the artificial test user must have either or both an email address and mobile number. It is also possible to test failing cases where the addressed signer does not meet the necessary requirements in order to participate in a signature job, be it missing contact information and/or have opted out from electronic communication from the public sector.
