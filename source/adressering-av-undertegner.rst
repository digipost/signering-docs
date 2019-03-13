Adressering
************

Signeringstjenesten tilbyr varsel og oppdrag til signering på SMS og e-post.

Kontaktinformasjon
===================

Kontaktinformasjon kan angis på to måter, og det er i hovedsak avhengig om du er en privat eller offentlig virksomhet.

Som offentlig virksomhet er du pålagt å bruke Kontakt- og reservasjonsregisteret for å innhente kontaktinformasjon. Dette settes ved oppretting av oppdraget, og selve oppslaget gjøres av Posten signering.

..  NOTE::
Det er kun tillatt å overstyre kontaktinformasjon som en offentlig virksomhet hvis undertegner ikke signerer som privatperson.

Som privat virksomhet må du selv vite e-postadressen og/eller mobilnummeret til undertegner. Det er ikke mulig å bruke Kontakt- og reservasjonsregisteret.

Undertegner kan adresseres og identifiseres forskjellig avhengig av om undertegner signerer i direkteflyt eller portalflyt, og om avsender bruker API eller avsenderportalen.

Krav til kontaktinformasjon
____________________________

 * Alle undertegnere må ha minst ha én av e-postadresse og mobilnummer.
 * Sending av SMS er frivillig og kan bestilles av tjenesteeieren.
 * Dersom en undertegner har mobilnummer og ikke e-postadresse vil det alltid bli sendt SMS.
 * Tjenesten støtter kun norske mobilnumre. Oppdrag med overstyrt kontaktinformasjon med utenlandsk mobilnummer vil bli avvist, mens utenlandske mobilnumre fra Kontakt- og reservasjonsregisteret vil bli ignorert.

..  TIP::
    Hvis du behøver en introduksjon til de forskjellige flytene en undertegner kan signere i, se :ref:`signeringsflyt`.

..  CAUTION::
    Måten du adresserer undertegner på, påvirker :ref:`innholdet og utseendet på undertegners signatur <identifisereUndertegnere>`.

Adressering med fødselsnummer
===============================
Dette gir en sikker identifisering, siden kun riktig person har mulighet til å åpne og signere dokumentet.

Du må vite fnr. som avsender.

Signerte dokumenter vil inneholde navn på undertegner og hvilken elektronisk ID som ble brukt. Man kan for øvrig velge hvilken :ref:`identifikator man ønsker i signerte dokumenter <identifisereUndertegnere>`.


Signering i direkteflyt
________________________

Undertegner er logget inn i avsenders system.  Avsender er ansvarlig for å sende riktig person til riktig lenke i signeringstjenesten.


Signering i portalflyt
_______________________
Undertegner må logge inn i signeringsportalen før
man kan se og signere dokumentet.



Adressering uten fødselsnummer
===============================

Ved adressering uten fødselsnummer blir ikke signeringsoppdraget knyttet til en spesifikk person. Derfor krever signeringstypen ingen innlogging, og du trenger ikke vite undertegners fødselsnummer. I stedet sender du *kun* inn e-postadressen og/eller mobilnummeret som skal motta varsel om signeringen.  Se :ref:`varsler <varslerUtenFødselsnummer>` for å se hvordan varselet ser ut.

..  NOTE::
    Adressering uten fødselsnummer er tilgjengelig for bedrifter ved oppretting fra avsenderportal og API, og for offentlige virksomheter via API.

..  IMPORTANT::
    Selve signaturen er like sikker som når du adresserer med fødselsnummer, men du som avsender er ansvarlig for at riktig person åpner og signerer dokumentet.

Signering i direkteflyt
________________________

Du har mulighet til å bruke en egenvalgt identifikator. Dette kan f.eks. kundenummer, for å adresse undertegner.



Signering i portalflyt
_______________________
