Lagring
*********

.. _web-grensesnittet: https://signering.posten.no/virksomhet/#/logginn

Signerte dokumenter er i utgangspunktet tilgjengelig for nedlastning/henting i 40 dager etter signering. Etter dette blir de **slettet og utilgjengelige fra signeringstjenesten**.

Det er viktig å merke seg at beviskraften til digitale signaturer blir svakere over tid. Dette er fordi teknologien som forsegler signerte dokumenter blir utdatert i tråd med teknologisk utvikling. Vi anbefaler at dokumenter som krever beviskraft utover 3 år gjennomgår teknisk vedlikehold for å forsikre langvarig beviskraft.

For å sikre langvarig beviskraft og trygg lagring av signerte dokumenter tilbyr vi tilleggstjenesten *Langtidsvalidering og lagring*

.. _langtidsvalidering-og-lagring:

Langtidsvalidering og lagring
===============================

Ved å aktivere *Langtidsvalidering og lagring* tar Posten ansvar for at dine signerte dokumenter har beviskraft og gyldig validering i lang tid fremover (minst 50 år eller så lenge tjenesten finnes). Denne tilleggstjenesten aktiveres i virksomhetsinnstillingene i web-grensesnittet_ og koster 4 kroner per dokument.

Hvordan sikrer vi langtidsvalidering?
-------------------
Langtidsvalidering (LTV) dokumenterer tilstanden til det signerte dokumentet på signeringstidspunktet. Det signerte PDF-dokumentet (PAdES) for alle oppdrag som signeres i perioden *Langtidsvalidering og lagring* er aktivert blir umiddelbart flagget for teknisk preservering. 

Dokumenter som er flagget for langtidsvalidering gjennomgår teknisk preservering hvert 3. år (tid løper fra signeringstidspunkt) som oppdaterer kryptografien og forsterker forseglingen forsikrer at det signerte dokumentet ikke er endret etter signaturtidspunktet.

Hva skjer med dokumentene hvis jeg deaktiverer tjenesten?
-------------------
Alle dokumenter som ble signert i perioden *Langtidsvalidering og lagring* var aktivert vil forsatt være lagret, ha langvarig beviskraft og validering så lenge tjenesten finnes.

Hvordan får jeg tak i preserverte dokumenter?
-------------------
Langtidslagrede dokumenter kan lastes ned i webgrensesnittet, eller hentes via REST-grensesnittet for API-integratører på samme måte som alle andre signerte dokumenter. Se kodeeksempler for henting av signerte dokumenter i :ref:`signering-i-portalflyt` og :ref:`signering-i-direkteflyt`.

Sletting av dokumenter
=======================

Avsendere kan slette arkiverte dokumenter hvis de ønsker å fjerne dem fra arkivet.
Avsendere som bruker avsenderportalen kan slette dokumenter derfra.
For avsendere som integrerer via API, kan dokumentene slettes via REST-grensesnittet.

Begrensninger
___________________

- Alle undertegnere må ha signert før dokumentene kan slettes. Dokumenter som ikke blir signert av samtlige undertegnere vil slettes automatisk etter 40 dager, og kan ikke slettes manuelt av avsender.
- Dokumenter kan tidligst slettes 24 timer etter signeringtidspunkt, da undertegnerne skal ha mulighet til å laste ned dokumentet i et døgn.
- Dokumenter som skal sendes til undertegners digitale postkasse kan ikke slettes før de har blitt sendt dit. Dersom undertegner ikke har digital postkasse ventes det inntil 7 dager før dokumentene kan slettes.
