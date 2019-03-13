Adressering av undertegner
***************************
Måten undertegner adresseres og identifiseres på, er litt forskjellig avhengig av om han signerer i direkteflyt eller portalflyt, og om avsender bruker API eller avsenderportalen.

..  TIP::
    Hvis du ønsker å lese en introduksjon til de forskjellige flytene en undertegner kan signere i, se :ref:`signeringsflyt`.

..  CAUTION::
    Måten du adresserer undertegner på, påvirker :ref:`innholdet og utseendet på undertegners signatur <identifisereUndertegnere>`.

Posten signering sender ut varsel om signeringsoppdrag til undertegner på e-post og/eller SMS, hvis signering skjer i portalflyt. Ved signering i direkteflyt er det avsender som står for varsling til undertegner.

Avsender som bruker API kan
____________________________

- adressere med fødselsnummer
- adressere uten fødselsnummer
- adressere med egenvalgt identifikator (eksempelvis kundenummer)

Avsender som bruker avsenderportal på web kan
_____________________________________________

- adressere med fødselsnummer
- adressere uten fødselsnummer (N.B: Kun hvis privat virksomhet)


Det signerte dokumenter vil inneholde navn på undertegner og hvilken elektronisk ID som ble brukt. Man kan for øvrig velge hvilken :ref:`identifikator man ønsker i signerte dokumenter <identifisereUndertegnere>`. 


Adressering med fødselsnummer
===============================
For å adressere med fødselsnummer må du vite undertegners fødselsnummer, samt e-postadresse og/eller mobilnummer. Denne måten å adressere på gir en sikker identifisering av undertegner, siden kun én bestemt person har mulighet til å åpne og signere dokumentet.

Ved *signering i portalflyt* må undertegner logge inn i signeringsportalen før han kan se og signere dokumentet. Dette gjør altså at kun riktig person har mulighet til å lese og signere. Se signering i portalflyt, adressering med f.nr her.

Ved *signering i direkteflyt* er undertegner logget inn i avsenders system, og det er da avsender som er ansvarlig for å sende undertegner til riktig lenke i signeringstjenesten.

Når du som avsender velger adressering med fødselsnummer, kan du velge å inkludere fødselsnummeret i det signerte dokumentet. 


Adressering uten fødselsnummer
===============================

Ved adressering uten fødselsnummer blir ikke signeringsoppdraget knyttet til én spesifikk person. Derfor krever signeringstypen ingen innlogging, og du trenger ikke vite undertegners fødselsnummer. I stedet sender du *kun* inn e-postadressen og/eller mobilnummeret som skal motta varsel om signeringen.  Se :ref:`varsler <varslerUtenFødselsnummer>` for å se hvordan varselet ser ut.

Ved *signering i portalflyt* får undertegner en unik lenke og en kode, og han kan se og signere dokumentet uten innlogging. Se signering i portalflyt, adressering uten f.nr her.

Ved *signering i direkteflyt* 

Når du som avsender velger adressering uten fødselsnummer, vil ikke fødselsnummeret bli inkludert i det signerte dokumentet, av personvernmessige hensyn. Du vil fortsatt få med navn og eventuelt fødselsdato i det signerte dokumentet.

    
..  NOTE::
    Hvis du sender fra API har du mulighet til å bruke en egenvalgt identifikator i stedet for e-postadresse og mobilnummer. Dette kan f.eks. være et kundenummer.

..  IMPORTANT::
    Selve signaturen er like sikker og gyldig som når du adresserer med fødselsnummer, men du som avsender er ansvarlig for at riktig person åpner og signerer dokumentet.


Kontaktinformasjon (e-postadresse og mobilnummer)
=================================================

Som offentlig virksomhet er du pålagt å bruke Kontakt- og reservasjonsregisteret for å innhente kontaktinformasjon. Dette settes ved oppretting av oppdraget, og selve oppslaget gjøres av Posten signering.

..  NOTE::
Det er kun tillatt å overstyre kontaktinformasjon som en offentlig virksomhet hvis undertegner ikke signerer som privatperson, det vil si signerer i kraft av en rolle for en virksomhet.

Som privat virksomhet må du selv vite og legge til e-postadressen og/eller mobilnummeret til undertegner. Det er ikke mulig å bruke Kontakt- og reservasjonsregisteret.

Krav til kontaktinformasjon
____________________________

 * Alle undertegnere må ha minst én av e-postadresse og mobilnummer.
 * Sending av SMS er frivillig og kan bestilles av tjenesteeieren, dette koster 40 øre per SMS.
 * Dersom en undertegner har mobilnummer og ikke e-postadresse vil det alltid bli sendt SMS.
 * Tjenesten støtter kun norske mobilnumre. Oppdrag med overstyrt kontaktinformasjon med utenlandsk mobilnummer vil bli avvist, mens utenlandske mobilnumre fra Kontakt- og reservasjonsregisteret vil bli ignorert.
