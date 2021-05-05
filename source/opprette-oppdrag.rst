Opprette signeringsoppdrag
===========================

Ved opprettelse av signeringsoppdrag kan følgende felter angis:

+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Felt                      | Direkteflyt             | Portalflyt        | Ekstra informasjon                                            |
+===========================+=========================+===================+===============================================================+
| Dokumenter                | **Obligatorisk**        | **Obligatorisk**  | 1-20 dokumenter [#f4]_                                       |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Undertegner(e)            | **Obligatorisk**        | **Obligatorisk**  | se :ref:`adressering-av-undertegner`                          |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Tittel                    | **Obligatorisk**        | **Obligatorisk**  | Maks 80 tegn [#f1]_                                           |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Ikke-sensitiv tittel      | Ikke relevant           | Valgfritt         | Maks 80 tegn [#f1]_                                           |
| / Beskrivelse             |                         |                   |                                                               |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Signaturtype              | Valgfritt               | Valgfritt         | se :ref:`signaturtype`                                        |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Sikkerhetsnivå            | Valgfritt               | Valgfritt         | se :ref:`sikkerhetsnivå`                                      |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Melding til mottaker(e)   | Valgfritt               | Valgfritt         | Maks 220 tegn [#f1]_                                          |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Undertegners identifikator| Valgfritt               | Valgfritt         | se :ref:`adressering-av-undertegner`                          |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Aktiveringstidspunkt      | Ikke overstyrbar [#f2]_ | Valgfritt         |                                                               |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Levetid                   | Ikke overstyrbar [#f3]_ | Valgfritt         |                                                               |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| E-postadresse             | Ikke relevant           | **Obligatorisk**  | se :ref:`varsler`                                             |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Mobilnummer               | Ikke relevant           | Valgfritt         | se :ref:`varsler`                                             |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+
| Rekkefølge                | Ikke relevant           | Valgfritt         | se :ref:`kjedet-signering`                                    |
+---------------------------+-------------------------+-------------------+---------------------------------------------------------------+

.. rubric:: Footnotes

.. [#f1] Maks antall tillate tegn gjelder i både `direkte- <https://github.com/digipost/signature-api-specification/blob/2.7/schema/xsd/direct.xsd#L68-L75>`_ og `portalflyt <https://github.com/digipost/signature-api-specification/blob/2.7/schema/xsd/portal.xsd#L98-L105>`_.
.. [#f2] Signeringsoppdrag i direkteflyt blir alltid aktivert øyeblikkelig etter opprettelse. *Standardverdi* er *øyeblikkelig etter opprettelse*.
.. [#f3] Signeringsoppdrag i direkteflyt har alltid 30 dagers levetid for å unngå at et dokument blir signert uhensiktsmessig lenge etter opprettelsen av oppdraget. Eventuell frist fra avsenders perspektiv må kommuniseres og håndteres i avsenders tjenester.
.. [#f4] Flere dokumenter støttes kun for oppdrag hvor signaturtypen er "autentisert", se :ref:`autentisert-signatur`

For implementasjon for signeringsoppdrag i portalflyt, se  :ref:`portal-flow`, og for signeringsoppdrag i direkteflyt, se :ref:`direct-flow`.

Begrensninger
______________

Antall undertegnere
^^^^^^^^^^^^^^^^^^^^^

Et signeringsoppdrag kan ha flere undertegnere. Tjenesten tillater maksimalt 10 undertegnere pr. oppdrag.

Hastighet
^^^^^^^^^^^

Tjenesten tillater maksimalt 10 API-kall i sekundet per organisasjonsnummer. Hvis en avsender overskrider denne grensen vil API-et returnere :code:`HTTP 429 Too Many Requests`, og avsenderen vil bli blokkert i 30 sekunder.


..  _dokumentformat:

Dokumentformat
^^^^^^^^^^^^^^^^^

Tjenesten støtter dokumenter av typen PDF (:code:`.pdf`). Både PDF og PDF/A aksepteres av tjenesten. Det signerte dokumentet vil være av samme type som originaldokumentene.
Et eller flere originaldokumenter som er PDF/A gir et signert PAdES-dokument som er PDF/A, og et eller flere originaldokumenter som er PDF versjon 1.1 – 1.7 gir et signert PAdES-dokument som er PDF versjon 1.7. Dersom originaldokumentene inneholder både PDF og PDF/A vil det signerte dokumentet bli av typen PDF versjon 1.7.
For PDF/A vil tjenesten alltid produsere signerte PAdES-dokumenter av typen PDF/A-3b, uavhengig av PDF/A-versjon og -konformitetsnivå på originaldokumentene.

For arkivering av signerte dokumenter anbefaler vi å bruke originaldokumenter av typen PDF/A. Dette er et krav hvis det signerte dokumentet skal avleveres til Riksarkivet.

For testing kan du bruke eksempeldokumentene :download:`PDF-1.2 <files/PDF-1-2-testdokument.pdf>`, :download:`PDF-1.3 <files/PDF-1-3-testdokument.pdf>`, :download:`PDF-1.4 <files/PDF-1-4-testdokument.pdf>`, :download:`PDF-1.5 <files/PDF-1-5-testdokument.pdf>`, :download:`PDF-1.6 <files/PDF-1-6-testdokument.pdf>` og :download:`PDF-A <files/PDF-A-testdokument.pdf>`.

..  NOTE::
    Dokumentene kan til sammen være maksimalt 3 MB (:code:`3 145 728 bytes`) store. PDF-versjoner som støttes er PDF 1.1-1.7.

I PAdES vil dokumentene alltid presenteres i A4- og portrett-format. For best resultat anbefales det at de innsendte dokumentene også har dette formatet.

..  DANGER::
    Passordbeskyttede dokumenter (begrenset lese- og/eller skrive-tilgang) er ikke støttet av tjenesten og vil gi feilmelding først ved nedlasting av dokumentet.

Aktiveringstidspunkt
^^^^^^^^^^^^^^^^^^^^^^

Angir tidspunkt for når signeringsoppdraget skal tilgjengeliggjøres for undertegner(e). Dersom aktiveringstidspunktet er i fortiden, blir oppdraget tilgjengelig øyeblikkelig etter opprettelse.

Signeringsoppdrag i direkteflyt blir alltid aktivert øyeblikkelig etter opprettelse.

Oppdragets levetid
^^^^^^^^^^^^^^^^^^^^

Angir hvor lenge *etter aktivering* et signeringsoppdrag er tilgjengelig for undertegner før det utløper. Kan maksimalt være 90 dager etter aktivering.

Signeringsoppdrag i direkteflyt har alltid 30 dagers levetid for å unngå at dokumenter blir signert uhensiktsmessig lenge etter opprettelsen av oppdraget. Eventuell frist fra avsenders perspektiv må kommuniseres og håndteres i avsenders tjenester.
