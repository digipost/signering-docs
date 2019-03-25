Egenutviklet direkteintegrasjon via API
****************************************

Dette integrasjonsmønsteret vil passe for større tjenesteeiere som har egne portaler og nettløsninger, og som ønsker å tilby signering sømløst som en del av en prosess der brukeren allerede er innlogget i en sesjon på tjenesteeiers nettsider. Signeringsprosessen vil oppleves som en integrert del av brukerflyten på tjenesteiers sider, og brukeren blir derfor sendt tilbake til tjenesteeiers nettsider etter at signeringen er gjennomført.

Meldingsformatet i APIet er XML, og reelevante typer finnes i filen `direct.xsd <https://github.com/digipost/signature-api-specification/blob/master/schema/xsd/direct.xsd>`_.

|direkteflytskjema|
**Flytskjema signeringsoppdrag i direkteflyt:** *skjemaet viser at en undertegner logger i signeringsportalen, gjennomfører en signering, avsender som henter status, henter signert dokument og bekrefter prosessering. Heltrukne linjer viser brukerflyt, mens stiplede linjer viser API-kall.*

.. _egenDirekteIntegrasjonSteg1:

Steg 1: Opprette signeringsoppdraget
=====================================

Flyten begynner ved at tjenesteeier gjør et API-kall for å opprette signeringsoppdraget. Dette kallet gjøres som en multipart-request, der den ene delen er dokumentpakken og den andre delen er metadata.

-  Kallet gjøres som en ``HTTP POST`` mot ressursen ``<rot-URL>/direct/signature-jobs``
-  Dokumentpakken legges med multipart-kallet med mediatypen ``application/octet-stream``. Se forrige kapittel for mer informasjon om dokumentpakken.
-  Metadataene som skal sendes med i dette kallet er definert av elementet ``direct-signature-job-request``. Disse legges med multipart-kallet med mediatypen ``application/xml``.

En del av metadataene er et sett med URLer definert i elementet ``exit-urls``. Disse adressene vil bli benyttet av signeringstjenesten til å redirecte undertegneren tilbake til din portal ved fullført signering. Følgende tre URLer skal oppgis:

-  **completion-url:** Hvor undertegner sendes hvis signeringen er vellykket. Du kan da be om status for å få URLer til nedlasting av signert dokument.
-  **rejection-url:** Hvor undertegner sendes hvis hun selv velger å avbryte signeringen. Dette er en handling undertegneren *selv valgte* å gjennomføre.
-  **error-url:** Hvor undertegner sendes hvis det skjer noe galt under signeringen. Dette er noe undertegneren *ikke* valgte å gjøre selv.

Følgende er et eksempel på metadata for et signeringsoppdrag:

.. code:: xml

   <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
   <direct-signature-job-request xmlns="http://signering.posten.no/schema/v1">
       <reference>123-ABC</reference>
       <exit-urls>
           <completion-url>https://www.sender.org/completed</completion-url>
           <rejection-url>https://www.sender.org/rejected</rejection-url>
           <error-url>https://www.sender.org/failed</error-url>
       </exit-urls>
       <polling-queue>custom-queue</polling-queue>
   </direct-signature-job-request>

Følgende er et eksempel på ``manifest.xml`` fra dokumentpakken:

.. code:: xml

   <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
   <direct-signature-job-manifest xmlns="http://signering.posten.no/schema/v1">
       <signer>
           <personal-identification-number>12345678910</personal-identification-number>
           <signature-type>ADVANCED_ELECTRONIC_SIGNATURE</signature-type>
           <on-behalf-of>SELF</on-behalf-of>
       </signer>
       <sender>
           <organization-number>123456789</organization-number>
       </sender>
       <document href="document.pdf" mime="application/pdf">
           <title>Tittel</title>
           <description>Melding til undertegner</description>
       </document>
       <required-authentication>3</required-authentication>
       <identifier-in-signed-documents>PERSONAL_IDENTIFICATION_NUMBER_AND_NAME</identifier-in-signed-documents>
   </direct-signature-job-manifest>

Undertegner
============
Du bør se :ref:`varsler` og :ref:`adressering-av-undertegner` før du starter med dette kapitlet.

Undertegnere kan adresseres og varsles på ulike måter:

..  tabs::

    ..  tab:: Fødselsnummer

        ..  code-block:: xml

            <signer>
               <personal-identification-number>12345678910</personal-identification-number>
               <on-behalf-of>SELF</on-behalf-of>
            </signer>

        For et utfyllende eksempel, se gjerne `eksempelmanifest for signeringstype og autentisering i API-spesifikasjonen <https://github.com/digipost/signature-api-specification/blob/master/schema/examples/direct/manifest-specify-signtype-and-auth.xml>`_.

    ..  tab:: Selvvalgt identifikator

        Det er mulig å bruke en selvvalgt identifikator for å gjøre koblingen mellom en person i avsenders system og et signeringsoppdrag. En slik identifikator kan være hva som helst som gir mening. Eksempler på en slik selvvalgt identifikator kan være kundenummer.

        ..  code-block:: xml

            <signer>
                <signer-identifier>kundenummer-134AB47</signer-identifier>
                <on-behalf-of>SELF</on-behalf-of>
            </signer>

        For et utfyllende eksempel, se gjerne `eksempelmanifest for selvvalgt identifikator i API-spesifikasjonen <https://github.com/digipost/signature-api-specification/blob/master/schema/examples/direct/manifest-signer-without-pin.xml>`_.

    ..  tab:: På vegne av

        Attributtet ``on-behalf-of="OTHER"`` skal brukes hvis undertegner signerer i kraft av en rolle for en virksomhet. I praksis betyr dette at signert dokument sendes ikke videre til undertegners egen postkasse etter signering.

        ..  code-block:: xml

            <signer>
               <personal-identification-number>12345678910</personal-identification-number>
               <on-behalf-of>OTHER</on-behalf-of>
            </signer>

..  NOTE::
    ``signature-type`` spesifiseres per undertegner, som betyr at er mulig å innhente ulike typer signaturer fra ulike undertegnere for samme oppdrag. Dette er imidlertid antatt å være et såpass sjeldent use-case at det ikke er mulig via grensesnittet i avsenderportalen. Der spesifiseres signaturtype på jobbnivå.

Andre attributter
------------------

Sikkerhetsnivå
^^^^^^^^^^^^^^^
``required-authentication`` spesifiseres på jobbnivå ettersom dette også er knyttet til dokumentets sensitivitetsnivå.

Identifikator i signert dokument
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``identifier-in-signed-documents`` brukes for å angi hvordan undertegneren(e) skal identifiseres i de signerte dokumentene. Tillatte verdier er ``PERSONAL_IDENTIFICATION_NUMBER_AND_NAME``, ``DATE_OF_BIRTH_AND_NAME`` og ``NAME``, men ikke alle er gyldige for alle typer signeringsoppdrag og avsendere.

Respons
--------

Som respons på dette kallet vil man få en respons definert av elementet ``direct-signature-job-response``. Denne responsen inneholder en URL (``redirect-url``) som man redirecter brukerens nettleser til for å starte signeringen. I tillegg inneholder den en URL du benytter for å spørre om status på oppdraget. Her skal man **IKKE** benytte seg av polling, men derimot vente til brukeren returneres til en av URLene definert i requesten, for deretter å gjøre kallet. For å forhindre polling kreves det et token som du får tilbake ved redirecten, se :ref:`egenDirekteIntegrasjonSteg3` for nærmere forklaring.

.. code:: xml

   <direct-signature-job-response xmlns="http://signering.posten.no/schema/v1">
       <signature-job-id>1</signature-job-id>
       <redirect-url>
           https://signering.posten.no#/redirect/421e7ac38da1f81150cfae8a053cef62f9e7433ffd9395e5805e820980653657
       </redirect-url>
       <status-url>https://api.signering.posten.no/api/{sender-identifier}/direct/signature-jobs/1/status</status-url>
   </direct-signature-job-response>

.. _egenDirekteIntegrasjonSteg2:

Steg 2: Signering av oppdraget
================================

Hele dette steget gjennomføres i signeringsportalen. Du videresender brukeren til portalen ved å benytte URLen du får som svar på opprettelsen av oppdraget. Denne linken inneholder et engangstoken generert av signeringstjenesten, og det er dette tokenet som gjør at brukeren får tilgang til å lese dokumentet og gjennomføre signeringen.

..  IMPORTANT::
    **Sikkerhet i forbindelse med engangstoken:** For å håndtere sikkerheten i dette kallet vil tokenet kun fungere én gang. Brukeren vil få en cookie av signeringstjenesten ved første kall, slik at en eventuell refresh ikke stopper flyten, men du kan ikke bruke denne URLen på et senere tidspunkt. Årsaken til at vi kun tillater at den brukes én gang er at URLer kan fremkomme i eventuelle mellomtjeneres logger, og de vil dermed ikke være sikre etter å ha blitt benyttet første gang.

Brukeren gjennomfører signeringen og blir deretter sendt tilbake til din portal via URLen spesifisert av deg i ``completion-url``. På slutten av denne URLen vil det legges på et query-parameter (``status_query_token``) du senere skal benytte når du spør om status.

.. _egenDirekteIntegrasjonSteg3:

Steg 3: Hent status
====================

Når brukeren blir sendt tilbake til din portal skal du gjøre et API-kall (``HTTP GET``) for å hente ned status. Dette gjøres ved å benytte ``status-url`` du fikk i :ref:`egenDirekteIntegrasjonSteg1` og query-parameter (``status_query_token``) du fikk i :ref:`egenDirekteIntegrasjonSteg2`.

Responsen fra dette kallet er definert gjennom elementet ``direct-signature-job-status-response``. Et eksempel på denne responsen ved et suksessfullt signeringsoppdrag vises under:

.. code:: xml

   <direct-signature-job-status-response xmlns="http://signering.posten.no/schema/v1">
       <signature-job-id>1</signature-job-id>
       <signature-job-status>COMPLETED_SUCCESSFULLY</signature-job-status>
       <status since="2017-01-23T12:51:43+01:00">SIGNED</status>
       <confirmation-url>https://api.signering.posten.no/api/{sender-identifier}/direct/signature-jobs/1/complete</confirmation-url>
       <xades-url>https://api.signering.posten.no/api/{sender-identifier}/direct/signature-jobs/1/xades/1</xades-url>
       <pades-url>https://api.signering.posten.no/api/{sender-identifier}/direct/signature-jobs/1/pades</pades-url>
   </direct-signature-job-status-response>

..  NOTE::
    Hvis signeringsoppdraget er lagt på en spesifikk kø, så må query-parameteret ``polling_queue`` settes til navnet på køen. Dette er kun relevant når ``status-retrieval-method`` er satt til ``POLLING``.

Steg 4: Laste ned PAdES eller XAdES
-----------------------------------

I forrige steg fikk du to lenker: ``xades-url`` og ``pades-url``. Disse kan du gjøre en ``HTTP GET`` på for å laste ned det signerte dokumentet i de to formatene. For mer informasjon om format på det signerte dokumentet, se :ref:`signerte-dokumenter`.

Steg 5: Bekrefte ferdig prosessering
------------------------------------

Til slutt gjør du et ``HTTP POST``-kall mot ``confirmation-url`` for å bekrefte at du har prosessert jobben ferdig. Hvis :ref:`langtidslagring` benyttes vil dette markere oppdraget som ferdig og lagret. I motsatt fall vil oppdraget slettes fra signeringsportalen.

..  |direkteflytskjema| image:: https://raw.githubusercontent.com/digipost/signature-api-specification/master/integrasjon/flytskjemaer/synkron-maskin-til-maskin.png
    :alt: Flytskjema for direkteintegrasjon