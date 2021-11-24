Notification texts for senders
============================

All senders are registered in the service with an email address, and notifications are therefore sent by email. A sender’s email address is linked to the user in the service and is never sent in when a request is created.

..  NOTE::
    Only the user who created the signature request will receive emails linked to a request.

Notifications are sent to the sender in three cases:

1. **When a signature request changes status**: The notification includes an overview of all signers' signing status. One email is sent for each signer as "do something", i.e. sign or reject, or when the signing deadline has passed.

2. **24 hours before the signing deadline for a request expires**: The notification is sent out as a reminder to the sender that someone still has not signed. The sender can then choose to defer the signing deadline, or remind the signers by sending an extra notification. **NB:** The notification is only sent if the request's original signing deadline was more than 48 hours.

3. **Four days before archiving of the signed document expires**: The notification is sent out as a reminder to the sender if the documents have been signed by all recipients, and *only* if the sender has not downloaded the signed document. Posten signering offers :ref:`long-term-validation-and-storage` for senders who do not want to have to download and retain signed documents.


Notification when signature request changes status (in Norwegian)
__________________________________________

..  tabs::

    ..  tab:: Statusendring

        **Emne**: Oppdatert signeringsstatus: [*senders-reference*] er [*delvis signert*]/[*ferdig signert*]/[*ferdig, men ufullstendig*]

        Hei!
        Vi vil informere deg om at signeringsforespørselen med referanse [*senders-reference*] har endret status til [*delvis signert*]/[*ferdig signert*]/[*ferdig, men ufullstendig*].

        Undertegner ********: [*Venter*]/[*Avvist*]/[*Signert*]/[*Sperret*]

        Logg deg inn på [*https://signering.posten.no/virksomhet/#/*] for å se detaljer om dokumentet.

        Hilsen oss i Posten signering


    ..  tab:: Fristen går snart ut

        **Emne**: Signeringsfristen går ut om 24 timer

        Hei!

        Forespørselen med referanse [*XXXX*] er fortsatt ikke signert av [*undertegnere*].

        Det er nå kun 24 timer til signeringsfristen utløper. Du kan utsette fristen ved å logge inn og klikke på "Utsett signeringsfrist".

        Om dokument(ene) ikke signeres innen fristen, stoppes prosessen, og du må eventuelt opprette en ny forespørsel for å innhente signaturer.

        Logg deg inn på [*https://signering.posten.no/virksomhet/#/*] for å utsette fristen eller for å se detaljer om forespørselen.

        Hilsen oss i Posten signering


Notification before archiving of signed document expires (in Norwegian)
_______________________________________________________

..  tabs::

    ..  tab:: Arkiveringstid utløper snart

        **Emne**: Påminnelse om å laste ned [ikke-sensitiv dokumenttittel] innen [arkivering utløper dato *minus* 1 dag]

        Hei!

        Husk å ta godt vare på signerte dokumenter.

        **[ikke-sensitiv dokumenttittel]** (referanse: [refereanse]) er ikke lastet ned og vil slettes den **[arkivering utløper dato *minus* 1 dag]**. `Logg inn <https://test.signering.posten.no/virksomhet/#/logginn/privat>`_ for å laste ned dokumentet. Dette er siste påminnelse.

        Trenger du et sikkert lagringsalternativ? Les mer om dette på `<https://signering.posten.no/virksomhet/#/hjelp/lagring/langtidsvalidering>`_.

        Hilsen oss i Posten signering
