.. _notification-rules-for-sending:

Notifications: Rules for issue of notifications
===============================================

To ensure that the signer receives notifications and reminders at appropriate intervals, the times when notifications are sent out will depend on the signing deadline for a request.

If the sender has added both the email address and the mobile number of the signer, up to 3 notifications are sent about the signing: An initial email notification immediately after activation, an email reminder and, finally, a last SMS reminder. The background to this set-up is that email is used as the primary notification channel and that the SMS must function as a final, escalating notification.

================ ======================= ======================= ====================
Signing deadline 1. notification: e-mail 2. notification: e-mail 3. notification: SMS
================ ======================= ======================= ====================
0-24 hours       On activation                                   On activation
2-3 days         On activation           1 day before deadline   1 day before deadline
4-5 days         On activation           2 days before deadline  1 days before deadline
6-9 days         On activation           3 days before deadline  2 days before deadline
10+ days         On activation           5 days before deadline  2 days before deadline
================ ======================= ======================= ====================

.. raw:: html

   <!-- Tabellen er generert vha. http://www.tablesgenerator.com/markdown_tables -->

If the sender has only added the email address or mobile number of the signer, up to 2 notifications are sent about the signing: An initial notification immediately after activation and one reminder by e-mail or SMS, respectively.

================ =========================== ===========================
Signing deadline 1. notification: e-mail/SMS 2. notification: e-mail/SMS
================ =========================== ===========================
0-24 hours       On activation
2-3 days         On activation               1 day before deadline
4-5 days         On activation               2 days before deadline
6-9 days         On activation               3 days before deadline
10+ days         On activation               5 days before deadline
================ =========================== ===========================

.. raw:: html

   <!-- Tabellen er generert vha. http://www.tablesgenerator.com/markdown_tables -->

.. NOTE:: No SMS is sent between 22:00 and 8:00, unless the request is created at night and the deadline is so short that it has to be sent immediately.

.. NOTE:: If the sender *extends the signing deadline*, all scheduled notifications for the request will be deleted. New notifications will then be generated and sent out at an appropriate time in relation to the new deadline.

.. CAUTION:: To avoid accidentally sending notifications to actual persons in test environments, a security mechanism has been included in difitest: email notifications include a sentence to indicate that the notification comes from a test environment: ''This is a test email sent for Digdir from Posten signering" and the SMS notifications are replaced in their entirety with the sentence: "This is a test SMS sent for Digdir from Posten signering".


Signer notification texts
===============================

The set-up of the notifications that are sent out is predefined and may not be changed for you as the sender, but you can add a title/description of the documents to be signed.

The content of the notification will vary according to

- whether the addressing of the signer is with or without national identity number
- which channel the notifications are sent in (e-mail/SMS)
- the sector from which the sender sends (private or public)
- the number of signers for the request

The different notification versions sent by email and SMS are shown below (in Norwegian).


Notification of document for signing, on addressing with national identity number
_________________________________________________________________________________

..  tabs::

    ..  tab:: E-post 1. varsel

        **Emne**: Forespørsel om digital signering fra [*Avsender*]

        Hei!

        Du har fått en forespørsel om å signere [*Tittel på dokumentet*] fra [*Avsender*].

        Les og signer innen: [*signeringsfrist*]

        Du signerer enkelt og trygt med [*disse elektroniske e-IDene*].

        Logg deg inn på [*signering.posten.no/logginn*] for å lese og signere.

        Hilsen oss i Posten signering


    ..  tab:: E-post 2. varsel

        **Emne**: Påminnelse: Forespørsel om digital signering fra [*Avsender*]

        Hei!

        Vi vil minne om at du fortsatt kan signere [*Tittel på dokumentet*] fra [*Avsender*].

        Dokumentet(ene) er nå signert av [*antall*] og må signeres innen [*signeringsfrist*].

        Du signerer enkelt og trygt med [*disse elektroniske e-IDene*].

        Logg deg inn på [*signering.posten.no/logginn*] for å lese og signere.

        Rekker du ikke å signere innen fristen? Usignerte dokumenter slettes når fristen går ut. Kontakt [*Avsender*] for å få tilsendt en ny forespørsel.

        Hilsen oss i Posten signering

..  tabs::

    ..  tab:: SMS 1. varsel

        Du har en signeringsforespørsel fra [*Avsender*]. Logg inn og signer på [*signering.posten.no/logginn*] innen [*signeringsfrist*]. Hilsen Posten

    ..  tab:: SMS 2./3. varsel

        Husk signering for [*Avsender*]. Logg inn og signer på [*signering.posten.no/logginn*] innen [*signeringsfrist*]. Hilsen Posten

.. _notifications-without-national-identity:

Notification of document for signing, on addressing by email / SMS
____________________________________________________________________

..  tabs::

    ..  tab:: E-post 1. varsel

        **Emne**: Forespørsel om digital signering fra [*Avsender*]

        Hei!
        Du har fått en forespørsel om å signere [*Dokumenttittel*] fra [*Avsender*].

        Les og signer innen: [*signeringsfrist*].

        Du signerer enkelt og trygt med [*disse elektroniske ID-ene*].

        Slik signerer du:
        1) Klikk på lenken under
        2) Skriv inn sikkerhetskode XXXX
        3) Les forespørsel og signer

        [*https://signering.posten.no/uniklenke*]

        Hilsen oss i Posten signering

    ..  tab:: E-post 2. varsel

        **Emne**: Forespørsel om digital signering fra [*Avsender*]

        Hei!
        Vi vil minne om at du fortsatt kan signere [*Dokumenttittel*] fra [*Avsender*].

        Les og signer innen: [*signeringsfrist*].

        Du signerer enkelt og trygt med [*disse elektroniske ID-ene*].

        Slik signerer du:
        1) Klikk på lenken under
        2) Skriv inn sikkerhetskode [*XXX*]
        3) Les forespørsel og signer

        [*https://signering.posten.no/uniklenke*]

        Rekker du ikke å signere innen fristen?
        Usignerte dokumenter slettes når fristen går ut. Kontakt [*Avsender*] for å få tilsendt en ny forespørsel.

        Hilsen oss i Posten signering

.. tabs::

    ..  tab:: SMS 1. varsel

        Hei! [*Avsender*] ber deg om en signatur. Bruk kode [*XXXX*] på [*https://signering.posten.no/uniklenke*] før [*signeringsfrist*].

    ..  tab:: SMS 2./3. varsel

        Hei! Husk signering for [*Avsender*]. Bruk kode [*XXXX*] på [*https://signering.posten.no/uniklenke*] før [*signeringsfrist*].



After signing: Notification of lookup in digital mailbox
________________________________________________________

After a signer has signed a document, in *these cases* the signer will be able create a digital mailbox. If the sender is a private organization, the signer will be able to create an account at Digipost, and if the sender is a public organization, the signer will be able to select a digital mailbox at Norge.no.

The content of this notification will vary according to how many signers are to sign the document, and whether the sender is private or public.

Private senders
^^^^^^^^^^^^^^^^^^^

..  tabs::

    ..  tab:: E-post, én undertegner

        **Emne**: Motta det signerte dokumentet i Digipost

        Hei!

        Du har nettopp signert et dokument fra [*Avsender*] gjennom Posten signering.

        Hvis du oppretter en konto i Digipost innen 7 dager, sendes dokumentet du signerte automatisk dit. Da har du det              lett tilgjengelig når du trenger det!

        Registrer deg i Digipost: https://www.digipost.no/app/registrering ,

        Hilsen oss i Posten signering

    ..  tab:: E-post, flere undertegnere

        **Emne**: Motta det signerte dokumentet i Digipost

        Hei!

        Du har tidligere signert et dokument fra [*Avsender*] gjennom Posten signering. Nå har alle undertegnerne signert, og avsender har mottatt det ferdigsignerte dokumentet.

        Hvis du også ønsker å motta dokumentet med alle signaturer, må du opprette en konto i Digipost innen 7 dager. Da sendes dokumentet automatisk dit, så har du det lett tilgjengelig når du trenger det.

        Registrer deg i Digipost: https://www.digipost.no/app/registrering ,

        Hilsen oss i Posten signering


..  tabs::

    ..  tab:: SMS, én undertegner

        Hei, du har nettopp signert et dokument fra [*Avsender*] gjennom Posten signering.
        Hvis du oppretter en konto i Digipost innen 7 dager, sendes dokumentet du signerte automatisk dit: https://www.digipost.no/app/registrering

    ..  tab:: SMS, flere undertegnere

        Hei! Du har tidligere signert et dokument fra [*Avsender*] gjennom Posten signering.

        Nå har alle undertegnerne signert. Hvis du også ønsker å motta dokumentet med alle signaturer, må du opprette en konto i Digipost innen 7 dager. Da sendes dokumentet automatisk dit, så har du det lett tilgjengelig når du trenger            det: https://www.digipost.no/app/registrering


Public senders
^^^^^^^^^^^^^^^^^^^^^

..  tabs::

    ..  tab:: E-post, én undertegner

        **Emne**: Motta det signerte dokumentet i din digitale postkasse

        Hei!

        Du har nettopp signert et dokument fra [*Avsender*] gjennom den nasjonale fellesløsningen e-Signering.

        Hvis du oppretter en konto i Digipost innen 7 dager, sendes dokumentet du signerte automatisk dit. Da har du det lett tilgjengelig når du trenger det!

        Opprett digital postkasse:
        https://www.norge.no/velg-digital-postkasse

        Hilsen oss i Posten signering

    ..  tab:: E-post, flere undertegnere

        **Emne**: Motta det signerte dokumentet i din digitale postkasse

        Hei!

        Du har tidligere signert et dokument fra [*Avsender*] gjennom den nasjonale fellesløsningen e-Signering. Nå har alle undertegnerne signert, og avsender har mottatt det ferdigsignerte dokumentet. Hvis du også ønsker å motta dokumentet          med alle signaturer, må du opprette en digital postkasse innen 7 dager. Da sendes dokumentet automatisk dit, så har du det tilgjengelig når du trenger det!

        Opprett digital postkasse:
        https://www.norge.no/velg-digital-postkasse

        Hilsen oss i Posten signering

..  tabs::

    ..  tab:: SMS, én undertegner

        Hei, du har nettopp signert et dokument fra [*Avsender*] gjennom den nasjonale fellesløsningen e-Signering.
        Hvis du oppretter en digital postkasse innen 7 dager, sendes dokumentet du signerte automatisk dit:                            https://www.norge.no/velg-digital-postkasse

    ..  tab:: SMS, flere undertegnere

        Hei, du har tidligere signert et dokument fra [*Avsender*] gjennom den nasjonale fellesløsningen e-Signering. Nå har alle undertegnerne signert. Hvis du også ønsker å motta dokumentet med alle signaturer, må du opprette en digital postkasse innen 7 dager. Da sendes dokumentet automatisk dit, så har du det lett tilgjengelig når du trenger det: https://www.norge.no/velg-digital-postkasse


Notification of cancelled request
_________________________________

If the sender cancels a signature request, a notification is sent to the signer about this:

..  tabs::

    ..  tab:: E-post

        **Emne**: Kansellert: Forespørsel om digital signering fra [*Avsender*]

        Hei!
        [*Avsender*] har trukket tilbake forespørselen om å signere [*Dokumenttittel*].
        Kontakt [*Avsender*] om du lurer på hvorfor de kansellerte, eller om du ønsker å få tilsendt en ny forespørsel.

        Hilsen oss i Posten signering


.. _varseltekster-for-avsendere:
