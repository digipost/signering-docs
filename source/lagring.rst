Lagring
*********

Langtidslagring
================

Posten signering tilbyr en tilleggstjeneste for langtidslagring av originaldokument og signerte dokumenter. Tjenesten må aktiveres før en avsender kan ta den i bruk.

For avsendere med langtidslagring aktivert, lagres alle dokumenter i minst **50 år**. Dersom langtidslagring *ikke* er aktivert kan dokumentene bli utilgjengeliggjort etter **40 dager**.

Avsendere som bruker avsenderportalen for sending av signeringsoppdrag, kan aksessere langtidslagrede dokumenter derfra. Dokumentene er tilgjengelig via REST-grensesnittet for avsendere som integrerer mot tjenen via API.

Signeringstjenesten langtidslagrer kun XAdES. Når man henter PAdES genereres denne der og da, basert på XAdES.

Sletting av dokumenter
=======================

Avsendere kan slette arkiverte dokumenter hvis de ønsker å fjerne dem fra arkivet. Avsendere som bruker avsenderportalen kan slette dokumenter derfra. Dokumentene kan slettes via REST-grensesnittet for avsendere som integrerer mot tjenen via API.

Begrensninger
___________________

- Alle undertegnere må ha signert før dokumentene kan slettes. Dokumenter som ikke blir signert av samtlige undertegnere vil slettes automatisk etter 40 dager, og kan ikke slettes manuelt av avsender.
- Dokumenter kan tidligst slettes 24 timer etter signeringtidspunkt, da undertegnerne skal ha mulighet til å laste ned dokumentet i et døgn.
- Dokumenter som skal sendes til undertegners digitale postkasse kan ikke slettes før de har blitt sendt dit. Dersom undertegner ikke har digital postkasse ventes det inntil 7 dager før dokumentene kan slettes.
