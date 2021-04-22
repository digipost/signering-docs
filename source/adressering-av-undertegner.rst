.. _adressering-av-undertegner:

Adressering av undertegner
***************************
Undertegnere som skal signere i :ref:`portalflyt <signering-i-portalflyt>` kan adresseres på to forskjellige måter;

1. På e-post og/eller SMS (Kun tilgjengelig for privat virksomheter)
2. Med fødselsnummer

..  CAUTION::
    Måten du adresserer undertegner på, påvirker :ref:`innhold og utseendet på undertegners signatur <identifisereUndertegnere>`.

1. Adressering på e-post / SMS
===============================

.. NOTE::
   Dette alternativet er kun tilgjengelig for private virksomheter

Ved adressering på e-post / SMS knyttes ikke signeringsforespørselen til et fødselsnummer. Vi har derfor ikke noen måte å verifisere at det er riktig person som leser og signerer. Det kreves derfor ikke innlogging for å lese og signere. Mottaker får e-post og/eller SMS med en unik kode og lenke som gir tilgang til forespørselen. Se :ref:`varsler <varslerUtenFødselsnummer>` for å se hvordan varselet ser ut.


..  IMPORTANT::
    Selve signaturen er like sikker og gyldig som når du adresserer med fødselsnummer, men du som avsender er ansvarlig for at riktig person leser og signerer.

Ved adressering på e-post / SMS blir ikke fødselsnummeret bli inkludert i det signerte dokumentet, av personvernmessige hensyn. Du vil fortsatt få med navn og eventuelt fødselsdato i det signerte dokumentet.

Se :ref:`Signering i portalflyt med adressering på e-post / SMS <signering-i-portalflyt-uten-fødselsnummer>` for mer informasjon og visuelle eksempler.

2. Adressering med fødselsnummer
================================
For å adressere med fødselsnummer må du vite undertegners fødselsnummer. Adressering med fødselsnummer er den sikreste måten å nå mottaker på siden det krever innlogging med elektronisk ID for å lese og signere.

Selvom undertegner adresseres med fødselsnummer varsles hun og får lenke til innlogging på e-post eller SMS – se :ref:`varsler og kontaktinformasjon <varsler>` for mer informasjon.


..  TIP::
    Se :ref:`signering i portalflyt med fødselsnummer <signering-i-portalflyt-med-fødselsnummer>` for mer informasjon og visuelle eksempler.


.. _varsler:


Varsler og kontaktinformasjon
-----------------------------

Når du velger signering i portalflyt sendes ut e-post og/eller SMS-varsler til undertegnerne.

 - Alle undertegnere må ha minst én av e-postadresse og mobilnummer.
 - Sending av SMS er frivillig og kan bestilles av tjenesteeieren, dette koster 40 øre per SMS.
 - Dersom en undertegner har mobilnummer og ikke e-postadresse vil det alltid bli sendt SMS.
 - Tjenesten støtter kun norske mobilnumre.

For private bedrifter
^^^^^^^^^^^^^^^^^^^^^
Dersom avsender er en **privat bedrift** må du selv oppgi e-postadressen og/eller mobilnummeret til mottaker. Dette gjelder også hvis du adresserer undertegner med fødselsnummer. Private virksomheter kan ikke bruke KRR. 

For offentlige virksomheter
^^^^^^^^^^^^^^^^^^^^^^^^^^^
For **offentlige virksomheter** henter vi e-post og mobilnummer til undertegner fra `Kontakt- og reservasjonsregisteret (KRR) <http://eid.difi.no/nb/kontakt-og-reservasjonsregisteret>`_. Det er kun dersom undertegner skal signere på vegne av en virksomhet at offentlige virksomheter kan definere egen kontaktinformasjon til undertegner.

..  CAUTION::
    Hvis undertegnere er reservert mot digital kommunikasjon vil oppdraget bli avvist og påfølgende uthenting av status for oppdraget vil gi en feil med informasjon om hvilke undertegnere som er reservert. Undertegnere med overstyrt kontaktinformasjon blir ikke sjekket for reservasjon.


Bruk av Kontakt- og reservasjonsregisteret
============================================

Ytterligere informasjon rundt bruk av Kontakt- og reservarsjonregisteret

Ved utsending av senere varsler (enten utsatt aktivering på grunn av kjedet signatur eller påminnelser) blir det gjort et nytt oppslag mot registeret for å hente ut den sist oppdaterte kontaktinformasjonen.

Dersom Oppslagstjenesten for Kontakt- og reservasjonsregisteret er utilgjengelig ved utsending av påminnelser vil resultatet fra oppslaget ved opprettelse av oppdraget bli brukt.

Reservasjon ved utsatte førstegangsvarsler: I scenariet der tjenesteeier har satt en kjedet rekkefølge på undertegnerne, og førstegangsvarsel skal sendes til en undertegner som i perioden mellom oppdraget ble opprettet og førstegangsvarsel skal sendes har reservert seg mot elektronisk kommunikasjon, så vil hele oppdraget feile.

Reservasjon ved påminnelser: Hvis sluttbrukeren har reservert seg etter at oppdraget ble opprettet, men oppdraget allerede er aktivert, vil det ikke bli sendt påminnelser (e-post/SMS), men oppdraget vil heller ikke feile før signeringsfristen eventuelt løper ut.

Oppdrag med overstyrt kontaktinformasjon med utenlandsk mobilnummer vil bli avvist, mens utenlandske mobilnumre fra Kontakt- og reservasjonsregisteret vil bli ignorert.
