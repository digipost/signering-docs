.. _adressering-av-undertegner:

Adressering av undertegner
***************************
Undertegner kan adresseres og identifiseres på tre forskjellige måter; 

1. Med fødselsnummer
2. Med e-post og/eller mobilnummer 
3. Med egenvalgt identifikator 

Adresseingsalternativene varierer ut i fra om avsender er en offentlig eller privat virksomhet, om dokumentet sendes via API, eller web-portal og hvilken :ref:`signeringsflyt` som skal benyttes.


+-----------------+-----------------+---------------------+---------------------------+----------------------+
|                 |                 |                                                                        |
|                 |                 |   Adressering / identifisering av undertegner                          |
+-----------------+-----------------+---------------------+---------------------------+----------------------+
|                 |                 |                     |                           |                      |
| Sendes fra      | Signeringsflyt  |  **Fødselsnummer**  | **E-post / mobilnummer**  | **Egenvalgt ID**     |
+-----------------+-----------------+---------------------+---------------------------+----------------------+
|                 |                 |                     |                           |                      |
|                 | **Direkte**     | Offentlig + Privat  |     Ingen                 | Offentlig + Privat   |
| **API**         +-----------------+---------------------+---------------------------+----------------------+
|                 |                 |                     |                           |                      |
|                 | **Portal**      | Offentlig + Privat  |     Privat                |        Ingen         |
+-----------------+-----------------+---------------------+---------------------------+----------------------+
|                 |                 |                     |                           |                      |
| **Web**         | **Portal**      | Offentlig + Privat  |     Privat                |        Ingen         |
+-----------------+-----------------+---------------------+---------------------------+----------------------+


..  CAUTION::
    Måten du adresserer undertegner på, påvirker :ref:`innhold og utseendet på undertegners signatur <identifisereUndertegnere>`.

1. Adressering med fødselsnummer
================================
For å adressere med fødselsnummer må du vite undertegners fødselsnummer. Denne måten å adressere på gir en sikker identifisering av undertegner, siden kun én bestemt person har mulighet til å åpne og signere dokumentet. 

Adressering med fødselsnummer og signering i portalflyt
-------------------------------------------------------
Undertegner må logge inn i signeringsportalen for å se og signere dokumentet. Dette gjør altså at kun riktig person har mulighet til å lese og signere. Undertegner får tilgang til signeringsportalen via varsel på e-post eller SMS.

Dersom avsender er en **privat bedrift** må e-postadressen og/eller mobilnummeret til mottaker oppgis i tillegg til fødselsnummer for å kunne varsle varsle mottaker. 

Dersom avsender er en **offentlig virksomhet** hentes e-postadressen og mobilnummeret til mottaker automatisk fra Kontakt- og reservasjonsregisteret. Det er kun hvis undertegnere signerer på vegne av en virksomhet eller en rolle at kontaktinformasjonen kan overstyres.

.. NOTE::
   Når du som avsender velger adressering med fødselsnummer, kan du velge å inkludere fødselsnummeret i det signerte dokumentet.

Se :ref:`Signering i portalflyt med fødselsnummer <signering-i-portalflyt-med-fødselsnummer>` for mer informasjon og visuelle eksempler.

Adressering med fødselsnummer og signering i direkteflyt
--------------------------------------------------------
Det sendes ikke ut noen automatisk varsling ved signering i direkteflyt. Det er avsenders ansvar å sende undertegner til riktig lenke i signeringstjenesten. 

Som oftest brukes signering i direkteflyt og adressering med fødselsnummer når undertegner er innlogget i avsenders systemer/nettsider med fødselsnummer.

Se :ref:`signering-i-direkteflyt` for mer informasjon og visuelle eksempler. 


2. Adressering på e-post / SMS
===============================

.. NOTE::
   Dette alternativet er kun tilgjengelig for private virksomheter

Ved adressering på e-post / SMS blir ikke signeringsoppdraget knyttet til én spesifikk person. Derfor krever signeringstypen ingen innlogging, og du trenger ikke vite undertegners fødselsnummer. I stedet sender du *kun* inn e-postadressen og/eller mobilnummeret som skal motta varsel om signeringen.  Se :ref:`varsler <varslerUtenFødselsnummer>` for å se hvordan varselet ser ut.


Når du som avsender velger adressering på e-post / SMS, vil ikke fødselsnummeret bli inkludert i det signerte dokumentet, av personvernmessige hensyn. Du vil fortsatt få med navn og eventuelt fødselsdato i det signerte dokumentet.

..  IMPORTANT::
    Selve signaturen er like sikker og gyldig som når du adresserer med fødselsnummer, men du som avsender er ansvarlig for at riktig person åpner og signerer dokumentet.

Se :ref:`Signering i portalflyt med adressering på e-post / SMS <signering-i-portalflyt-uten-fødselsnummer>` for mer informasjon og visuelle eksempler. 

3. Egenvalgt identifisering av undertegner
=======================================

.. NOTE::
   Dette alternativet er kun tilgjengelig ved signering i direkteflyt via API-integrasjon

Dette alternativet gir avsender mulighet til å bruke en egenvalgt identifikator for undertegner istedenfor fødselsnummer, e-postadresse og mobilnummer. Dette kan f.eks. være et kundenummer.

Se :ref:`signering-i-direkteflyt`  for mer informasjon og visuelle eksempler.

.. _varsler:


Varsler og kontaktinformasjon
*********************

 - Alle undertegnere må ha minst én av e-postadresse og mobilnummer.
 - Sending av SMS er frivillig og kan bestilles av tjenesteeieren, dette koster 40 øre per SMS.
 - Dersom en undertegner har mobilnummer og ikke e-postadresse vil det alltid bli sendt SMS.
 - Tjenesten støtter kun norske mobilnumre.

Som **privat bedrift** må du selv vite og legge til e-postadressen og/eller mobilnummeret til undertegner. Det er ikke mulig å bruke Kontakt- og reservasjonsregisteret.

For **offentlige virksomheter** gjør vi oppslag i `Kontakt- og reservasjonsregisteret (KRR) <https://samarbeid.difi.no/kontakt-og-reservasjonsregisteret>`_. Det er kun dersom undertegner skal signere på vegne av en virksomhet at offentlige virksomheter kan definere egen kontaktinformasjon til undertegner.

..  CAUTION::
    Hvis undertegnere er reservert mot digital kommunikasjon vil oppdraget bli avvist og påfølgende uthenting av status for oppdraget vil gi en feil med informasjon om hvilke undertegnere som er reservert. Undertegnere med overstyrt kontaktinformasjon blir ikke sjekket for reservasjon.


Bruk av Kontakt- og reservasjonsregisteret
============================================

Ytterligere informasjon rundt bruk av Kontakt- og reservarsjonregisteret

 - Ved utsending av senere varsler (enten utsatt aktivering på grunn av kjedet signatur eller påminnelser) blir det gjort et nytt oppslag mot registeret for å hente ut den sist oppdaterte kontaktinformasjonen.
 - Dersom Oppslagstjenesten for Kontakt- og reservasjonsregisteret er utilgjengelig ved utsending av påminnelser vil resultatet fra oppslaget ved opprettelse av oppdraget bli brukt.
 - Reservasjon ved utsatte førstegangsvarsler: I scenariet der tjenesteeier har satt en kjedet rekkefølge på undertegnerne, og førstegangsvarsel skal sendes til en undertegner som i perioden mellom oppdraget ble opprettet og førstegangsvarsel skal sendes har reservert seg mot elektronisk kommunikasjon, så vil hele oppdraget feile.
 - Reservasjon ved påminnelser: Hvis sluttbrukeren har reservert seg etter at oppdraget ble opprettet, men oppdraget allerede er aktivert, vil det ikke bli sendt påminnelser (e-post/SMS), men oppdraget vil heller ikke feile før signeringsfristen eventuelt løper ut.
 - Oppdrag med overstyrt kontaktinformasjon med utenlandsk mobilnummer vil bli avvist, mens utenlandske mobilnumre fra Kontakt- og reservasjonsregisteret vil bli ignorert.
