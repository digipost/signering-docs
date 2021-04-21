.. _signaturtype:

Signaturtype
*************

I Norge har vi tre forskjellige måter å signere digitalt på, som beskrevet i E-signaturloven: autentisert, avansert og kvalifisert. Autentisert signatur er en sterk signatur, avansert signatur er enda sterkere, og kvalifisert signatur er den sterkeste signaturen.

Vi tilbyr autentisert og avansert signatur, som er rettskraftige signaturer på lik linje med håndskrift på papir. Kvalifisert signatur eksisterer ikke per i dag, men er tenkt oppfylt på lang sikt gjennom Nasjonalt ID-kort.

..  _avansert-signatur:

Avansert signatur
==================

Ved bruk av avansert signatur skjer signering med BankID. Det gir en sterk knytning mellom identifiseringshandling og dokumentene som skal signeres.

En avansert signatur har en sterkere knytning mellom signaturen og dokumentene enn en :ref:`autentisert-signatur` fordi det kun er BankID som er involvert i prosessen.

..  TIP::
    Signering kan gjøres med BankId, Buypass eller BankID på mobil. [#footnoteSigneringsmetoderOffentlig]_

..  _autentisert-signatur:

Autentisert signatur
=====================

Ved bruk av autentisert signatur autentiseres brukeren i ID-porten. IDporten vet ikke at innloggingen er tilknyttet en signeringsseremoni og det er Signicats jobb å knytte autentiseringen og dokumentene til en signatur.

En autentisert signatur er litt svakere enn en avansert signatur fordi det er flere parter involvert og fordi det skjer i to steg.

Avsender kan velge :ref:`sikkerhetsnivå` på signeringen.

Valg av signaturtype
=====================

..  tabs::

    ..  tab:: Bedrift

        Som bedrift kan du kun velge avansert signatur og trenger derfor ikke sette denne eksplisitt.

    ..  tab:: Offentlig virksomhet

        Som offentlig virksomhet kan du velge mellom :ref:`avansert-signatur` og :ref:`autentisert-signatur`. Digitaliseringsdirektoratet anbefaler offentlige virksomheter å bruke autentisert signatur fordi det er billigere, samtidig som det oppfyller de kravene som stilles i offentlig sektor.

        ..  NOTE::
            Standardverdi for signaturtype er autentisert.

.. rubric:: Fotnoter

.. [#footnoteSigneringsmetoderOffentlig] BankID på mobil er ikke tilgjengelig for avanserte oppdrag fra offentlig virksomhet.
