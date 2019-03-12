Adressering
************

Undertegner kan adresseres og identifiseres forskjellig avhengig av om undertegner signerer i direkteflyt eller portalflyt, og om avsender bruker API eller avsenderportalen.

..  TIP::
    Hvis du behøver en introduksjon til de forskjellige flytene en undertegner kan signere i, se :ref:`signeringsflyt`.

..  CAUTION::
    Måten du adresserer undertegner på, påvirker :ref:`innholdet og utseendet på undertegners signatur <identifisereUndertegnere>`.

Adressering med fødselsnummer
===============================
Dette gir en sikker identifisering, da kun riktig person har mulighet til å åpne og signere dokumentet.

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