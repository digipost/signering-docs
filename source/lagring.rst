Lagring
*********

.. _portalflyt: https://signering-docs.readthedocs.io/en/latest/client-integration/portal-flow.html#step-3-get-signed-documents
.. _direkteflyt: https://signering-docs.readthedocs.io/en/latest/client-integration/direct-flow.html#step-4-get-signed-documents
.. _web-grensesnittet: https://signering.posten.no/virksomhet/#/logginn

Signerte dokumenter er i utgangspunktet tilgjengelig for nedlastning/henting i 40 dager etter signering. Etter dette blir de **slettet og utilgjengelige fra signeringstjenesten**. 

Det er viktig å merke seg at beviskraften til digitale signaturer blir svakere over tid. Dette er fordi teknologien som forsegler signerte dokumenter blir utdatert i tråd med teknologisk utvikling. Vi anbefaler at dokumenter som krever beviskraft utover 3 år gjennomgår teknisk vedlikehold for å forsikre langvarig beviskraft.

For å sikre langvarig beviskraft og lagring av signerte dokumenter tilbyr vi tilleggstjenesten *Langtidsvalidering og lagring*

Langtidsvalidering og lagring
===============================

Denne tilleggstjenesten aktiveres i virksomhetsinnstillingene i web-grensesnittet_ . Alle dokumenter som signeres når *Langtidsvalidering og lagring* er aktivert blir umiddelbart flagget for langtidsvalidering og lagring. Disse dokumentene vil være tilgjengelige og ha garantert beviskraft i minst 50 år. 

Langtidslagrede dokumenter kan lastes ned i webgrensesnittet, eller hentes via REST-grensesnittet for API-integratører. Se kodeeksempler for henting av signerte dokumenter i portalflyt_ og direkteflyt_. 

Signeringstjenesten langtidslagrer og preserverer det signerte PDF dokumentet (PAdES). Dette gjennomgår teknisk vedlikehold hvert 3. år (tid løper fra signeringstidspunkt) som forsterker kryptografien som brukes til å forsikre om at de signerte dokumentene ikke er endret etter signaturtidspunktet. 

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
