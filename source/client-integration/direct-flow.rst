.. _direct-flow:

Direct flow
****************************

This is an integration pattern suited for senders with their own portals and web solutions, wishing to offer a seamless signing experience as a part of a process where the user is logged in through a senders web portal. The signature prosess will be perceived as an integrated part of the user flow. The user will be redirected to the senders website after the signing is completed. For more information of the flow, please see :ref:`signing-in-direct-flow`.

To ease the integration, we provide C# and Java libraries. If you are creating your own client, you will have to interact directly with the API. The message format of the API is XML, and relevant types can be found in `direct.xsd <https://github.com/digipost/signature-api-specification/blob/master/schema/xsd/direct.xsd>`_.

|direkteflytskjema|

**Flow chart for signing in direct flow:** *The chart shows that a signer is sent to the signing portal from the sender's website and completes the signing process. The sender gets the status, gets the signed document and confirms processing of the job. Solid lines show user flow and dashed lines shows requests to and responses from the API.*

Having problems integrating?
==============================

..  TIP::
    Remember that if you are having problems creating a job in a direct signature flow, you can always get in touch with a developer on Github:

    ..  tabs::

        ..  group-tab:: C#

            Get help for your `C# integration here <https://github.com/digipost/signature-api-client-dotnet/issues>`_.

        ..  group-tab:: Java

            Get help for your `Java integration here <https://github.com/digipost/signature-api-client-java/issues>`_.

        ..  group-tab:: HTTP

            Get help for your `HTTP integration here <https://github.com/digipost/signature-api-specification/issues>`_.

.. _directIntegrationStep1:

Step 1: Create signature job
===============================

..  tabs::

    .. group-tab:: C#

        ..  code-block:: c#

            ClientConfiguration clientConfiguration = null; //As initialized earlier
            var directClient = new DirectClient(clientConfiguration);

            var documentsToSign = new List<Document>
            {
                new Document(
                    "Document title",
                    FileType.Pdf,
                    @"C:\Path\ToDocument\File.pdf")
            };

            var exitUrls = new ExitUrls(
                new Uri("http://redirectUrl.no/onCompletion"),
                new Uri("http://redirectUrl.no/onCancellation"),
                new Uri("http://redirectUrl.no/onError")
            );

            var signers = new List<Signer>
            {
                new Signer(new PersonalIdentificationNumber("12345678910")),
                new Signer(new PersonalIdentificationNumber("10987654321"))
            };

            var job = new Job("Job title", documentsToSign, signers, "SendersReferenceToSignatureJob", exitUrls);

            var directJobResponse = await directClient.Create(job);

    ..  group-tab:: Java

        ..  code-block:: java

            ClientConfiguration clientConfiguration = null; // As initialized earlier
            DirectClient client = new DirectClient(clientConfiguration);

            byte[] document1Bytes = null; // Load document bytes
            byte[] document2Bytes = null; // Load document bytes
            List<DirectDocument> documents = Arrays.asList(
                    DirectDocument.builder("Document 1 title", document1Bytes).build(),
                    DirectDocument.builder("Document 2 title", document2Bytes).build());

            List<DirectSigner> signers = Collections.singletonList(DirectSigner
                    .withPersonalIdentificationNumber("12345678910")
                    .build());

            ExitUrls exitUrls = ExitUrls.of(
                    URI.create("http://sender.org/onCompletion"),
                    URI.create("http://sender.org/onRejection"),
                    URI.create("http://sender.org/onError"));

            DirectJob job = DirectJob
                    .builder("Job title", documents, signers, exitUrls)
                    .build();

            DirectJobResponse jobResponse = client.create(job);

    ..  group-tab:: HTTP

        The flow starts when the sender sends a request to create the signature job to the API. This request is a `multipart message <https://en.wikipedia.org/wiki/MIME#Multipart_messages>`_ comprised of a document bundle part and a metadata part.

        - The request is a ``HTTP POST`` to the resource ``api.<environment>.signering.posten.no/api/<organization-number>/direct/signature-jobs``, where ``<environment>`` is ``difitest`` or just remove the environment part for the production environment.
        - The document bundle is added to the multipart message with ``application/octet-stream`` as media type. See :ref:`information-about-document-package` for more information on the document bundle.
        - The metadata in the multipart request is defined by the ``direct-signature-job-request`` element. These are added with media type ``application/xml``.

        The following example shows the metadata for a signature job:

        ..  code-block:: xml

            <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
            <direct-signature-job-request xmlns="http://signering.posten.no/schema/v1">
               <reference>123-ABC</reference>
               <exit-urls>
                   <completion-url>https://www.sender.org/completed</completion-url>
                   <rejection-url>https://www.sender.org/rejected</rejection-url>
                   <error-url>https://www.sender.org/failed</error-url>
               </exit-urls>
               <polling-queue>custom-queue</polling-queue>
            </direct-signature-job-request>

        A part of the metadata is a set of URLs defined by the element ``exit-urls``. These URLs will be used by the signature service to redirect the signer back to the sender's portal after completing the signing. The following three URLs must be defined:

        -  **completion-url:** The signer is sent here after a successful signing process.
        -  **rejection-url:** The signer is sent here if *he or she chooses* to cancel the signing process.
        -  **error-url:** The signer is sent here if something fails during the signing process. This *is not* a result of a user action.

        The following is an example of the ``manifest.xml`` from the document bundle:

        ..  code-block:: xml

            <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
            <direct-signature-job-manifest xmlns="http://signering.posten.no/schema/v1">
                <signer>
                   <personal-identification-number>12345678910</personal-identification-number>
                   <signature-type>ADVANCED_ELECTRONIC_SIGNATURE</signature-type>
                   <on-behalf-of>SELF</on-behalf-of>
                </signer>
                <sender>
                   <organization-number>123456789</organization-number>
                </sender>
                <title>Tittel på oppdrag</title>
                <description>Informativ beskrivelse av oppdraget</description>
                <documents>
                    <document href="document.pdf" mime="application/pdf">
                        <title>Tittel på dokument</title>
                    </document>
                </documents>
                <required-authentication>3</required-authentication>
                <identifier-in-signed-documents>PERSONAL_IDENTIFICATION_NUMBER_AND_NAME</identifier-in-signed-documents>
            </direct-signature-job-manifest>


..  NOTE:: You can specify a signature type and required authentication level. If signature type or required authentication level is omitted, default values will be set as specified by :ref:`signature-type` and :ref:`security-level`.

..  tabs::

    ..  group-tab:: C#

        ..  code-block:: c#

            List<Document> documentsToSign = null; //As initialized earlier
            ExitUrls exitUrls = null; //As initialized earlier
            var signers = new List<Signer>
            {
                new Signer(new PersonalIdentificationNumber("12345678910"))
                {
                    SignatureType = SignatureType.AdvancedSignature
                }
            };

            var job = new Job(documentsToSign, signers, "SendersReferenceToSignatureJob", exitUrls)
            {
                AuthenticationLevel = AuthenticationLevel.Four
            };

    ..  group-tab:: Java

        ..  code-block:: java

            // documents and exitUrls as previous example

            List<DirectSigner> signers = Collections.singletonList(DirectSigner
                    .withPersonalIdentificationNumber("12345678910")
                    .withSignatureType(SignatureType.ADVANCED_SIGNATURE)
                    .build());

            DirectJob job = DirectJob
                    .builder("Job title", documents, signers, exitUrls)
                    .requireAuthentication(AuthenticationLevel.FOUR)
                    .build();


    ..  group-tab:: HTTP

        Signature type and required authentication level can be specified in the ``manifest.xml`` file in the document bundle, and an example is available at `digipost/signature-api-specification on GitHub <https://github.com/digipost/signature-api-specification/blob/3.1.0/schema/examples/direct/manifest-specify-signtype-and-auth.xml>`_.


Identifying the signer
----------------------

When using direct flow you can identify the signer in two different ways:

- using their **personal identification number** (national ID). This is required if you prefer to include signers' national ID in the signatures and visible in the resulting signed document.
- using your own **custom identifier**, which is unique per signature job. E.g. a customer number or any string allowing your integration to distinguish each signer from one another within a signature job.

..  tabs::

    ..  group-tab:: C#

        ..  code-block:: c#

            Direct.Signer nationalIdSigner =
                    new Direct.Signer(new PersonalIdentificationNumber("12345678910"));

            Direct.Signer customIdSigner =
                    new Direct.Signer(new CustomIdentifier("customer-1234"));


    ..  group-tab:: Java

        ..  code-block:: java

            DirectSigner nationalIdSigner =
                    DirectSigner.withPersonalIdentificationNumber("12345678910").build();

            DirectSigner customIdSigner =
                    DirectSigner.withCustomIdentifier("customer-1234").build();


    ..  group-tab:: HTTP

        ..  code-block:: xml

            <signer>
                <personal-identification-number>12345678910</personal-identification-number>
            </signer>
            <signer>
                <signer-identifier>customer-1234</signer-identifier>
            </signer>

        For full examples of the two methods of identifying signers, see example manifest files in the API-specification:

        -  `manifest setting signature type and authentication level <https://github.com/digipost/signature-api-specification/blob/master/schema/examples/direct/manifest-specify-signtype-and-auth.xml>`_
        -  `manifest setting custom identifier <https://github.com/digipost/signature-api-specification/blob/master/schema/examples/direct/manifest-signer-without-pin.xml>`_




On behalf of
^^^^^^^^^^^^

A sender may specify if the signer is signing on behalf of themself or by virtue of a role.

The sender should `always set this attribute according to the nature of the signature`; if the person signs for a personal matter (``SELF``, default if not specified), or signing on behalf of anything not personal (``OTHER``), e.g. a contract for an organization or any other non-personal document.

Specifying on behalf of ``OTHER`` will slightly alter the behavior of some aspects of the signing flow, including but may not be limited to:

- It prevents automatic forwarding the document to the signer's personal digital mailbox (Digipost for private sector organizations, and the signer's chosen provider of digital mailbox for public sector).
- The signer will be informed during signing that the signature will be on behalf of "another entity", i.e. not on behalf of themselves.


..  tabs::

    ..  group-tab:: C#

        .. code-block:: c#

            Direct.Signer signer =
                    new Direct.Signer(new PersonalIdentificationNumber("12345678910"))
                    {
                        OnBehalfOf = OnBehalfOf.Other
                    };

    ..  group-tab:: Java

        .. code-block:: Java

            DirectSigner signer = DirectSigner
                    .withPersonalIdentificationNumber("12345678910")
                    .onBehalfOf(OnBehalfOf.OTHER)
                    .build();

    ..  group-tab:: HTTP

        .. code-block:: xml

            <signer>
               <personal-identification-number>12345678910</personal-identification-number>
               <on-behalf-of>OTHER</on-behalf-of>
            </signer>



Other settings
----------------

Identifier in the signed document
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Currently, there are three formats available for displaying the signers in signed documents:

- their `full name`
- their `full name` and `date of birth`
- their `full name` and `national ID` (restrictions apply)

Please note that these formats only specifies how to `display` text which refers to the signers. It is purely a layout setting, and does not affect the strength of how a person's signature is attached to the signed content.

For more information, see :ref:`identify-signers`.


..  tabs::

    ..  group-tab:: C#

        ..  code-block:: c#

            var job = new Job(documents, signers, ...)
            {
                IdentifierInSignedDocuments = IdentifierInSignedDocuments.DateOfBirthAndName
            };

    ..  group-tab:: Java

        ..  code-block:: java

            DirectJob directJob = DirectJob.builder("title", ...)
                .withIdentifierInSignedDocuments(
                        IdentifierInSignedDocuments.DATE_OF_BIRTH_AND_NAME)
                .build();

    ..  group-tab:: HTTP

        The element ``identifier-in-signed-documents`` in the `manifest.xml <https://github.com/digipost/signature-api-specification/blob/3.1.0/schema/examples/direct/manifest.xml#L14>`_ file is used to specify how signers are to be identified in the signed documents for the job. Allowed values:

        - ``PERSONAL_IDENTIFICATION_NUMBER_AND_NAME``
        - ``DATE_OF_BIRTH_AND_NAME``
        - ``NAME``



.. _directIntegrationSetStatusRetrievalMethod:

Status retrieval method
^^^^^^^^^^^^^^^^^^^^^^^^^

This option enables an alternative integration pattern for handling the result of the signing process. If not specified, retriving the signed document (or handling rejections or errors) should be triggered by the signer being redirected to one of the `exit-URLs` specified in :ref:`directIntegrationStep1`. This is the recommended setting, and will usually provide the best experience for the person signing the documents.

If for some reason it is not possible to have the relevant system responding to the exit-URLs, retrieving the status of the signing process, and download location for signed documents, can be done by `polling`.

In addition, if using the polling facility it is highly recommended to specify a `polling queue` name (see :ref:`directIntegrationQueuesMoreInformation` for more information). The polling procedure is explained later in :ref:`directIntegrationStatusByPolling`.

Note: in both cases, it is necessary to redirect the signer `somewhere`, so exit-URLs are mandatory in all cases.

..  tabs::

    ..  group-tab:: C#

        In our libraries, a ``PollingQueue`` is specified on the ``Sender``, and the same sender must be specified when polling to retrieve status changes. The ``Sender`` can be set globally in ``ClientConfiguration`` and/or on every signature job.

        ..  code-block:: c#

            var sender = new Sender("123456789",
                    new PollingQueue("CustomPollingQueue"));

            var job = new Job("title", ... ,
                sender, StatusRetrievalMethod.Polling
            );

    ..  group-tab:: Java

        In our libraries, a ``PollingQueue`` is specified on the ``Sender``, and the same sender must be specified when polling to retrieve status changes. The ``Sender`` can be set globally in ``ClientConfiguration`` and/or on every signature job.

        ..  code-block:: java

            Sender sender = new Sender("123456789",
                    PollingQueue.of("queue-name"));

            DirectJob directJob = DirectJob.builder("title", ...)
                    .withSender(sender)
                    .retrieveStatusBy(StatusRetrievalMethod.POLLING)
                    .build();

    ..  group-tab:: HTTP

        The element ``status-retrieval-method`` can be used to set how the sender wishes to get status updates for the signature job. ``WAIT_FOR_CALLBACK`` is the standard value, and means that the sender waits until a signer is sent to one of the URLs given by the element ``exit-urls`` before acting accordingly. The alternative is to use ``POLLING`` to specify regular polling to fetch status updates. We recommend using ``WAIT_FOR_CALLBACK``.

        ..  code-block:: xml

            <direct-signature-job-request xmlns="http://signering.posten.no/schema/v1">
                <reference>123-ABC</reference>
                <exit-urls>...</exit-urls>
                <status-retrieval-method>POLLING</status-retrieval-method>
                <polling-queue>queue-name-for-status-updates</polling-queue>
            </direct-signature-job-request>



Response
--------

The request to create a signature job will produce a response containing an ID for the created job, and the URL to redirect each signer for signing the document(s) of the job. There is also a `status-URL` for retrieving the status when the signer is redirected back to one of the exit-URLs which was defined in the request. The sender must wait until this happens, and then send a request to retrieve the latest status update. The status retrieval requires a token that is aquired when the signer is redirected. Please see :ref:`directIntegrationStep3` for information on this procedure.

..  NOTE:: Make sure to not mix up `signer-URLs` with the `redirect-URLs`. The signer-URL is for management of each signer by your integration, and the redirect-URL is for `redirecting` the browser of each person signing the documents.

..  TIP:: It is perfectly valid to ignore any redirect-URL contained in the initial response from creating the job. It is arguably less complex to instead `every time` at the moment you are going to redirect a signer to Posten signering, you first need to request a redirect-URL (see :ref:`directIntegrationStep2`). This way you will avoid handling expired redirect-URLs because resolved in the past because each redirect will always target a new valid URL for the signer.


..  tabs::

    ..  group-tab:: C#

        ..  code-block:: c#

            var directClient = //As created earlier
            Job job = new Job("title", ...);
            var directJobResponse = await directClient.Create(job);

            // Data in directJobResponse (e.g. SignerUrl for each Signer)
            // can be persisted for use later to resolve the URL to
            // redirect each signer to the signing procedure
            foreach (var signer in directJobResponse.Signers)
            {
                // persist e.g. signer.SignerUrl;
            }

    ..  group-tab:: Java

        ..  code-block:: java

            DirectClient client = // As initialized earlier
            DirectJob directJob = DirectJob.builder("title", ...).build()
            DirectJobResponse directJobResponse = client.create(directJob);

            // Data in directJobResponse (e.g. signerUrl for each signer)
            // can be persisted for use later to resolve the URL to
            // redirect each signer to the signing procedure
            for (var signer : directJobResponse.getSigners()) {
                //Persist e.g. signer.getSignerUrl();
            }

        See also Javadoc for `DirectJobResponse <https://javadoc.io/doc/no.digipost.signature/signature-api-client-java/latest/no/digipost/signature/client/direct/DirectJobResponse.html>`_.

    ..  group-tab:: HTTP

        The request will result in a response defined by the element ``direct-signature-job-response``. Examples for jobs with both `one signer <https://github.com/digipost/signature-api-specification/blob/3.1.0/schema/examples/direct/response.xml>`_ and `two signers <https://github.com/digipost/signature-api-specification/blob/3.1.0/schema/examples/direct/multiple_signers/response.xml>`_ can be found in the `API-specification <https://github.com/digipost/signature-api-specification>`_ repository on GitHub.



.. _directIntegrationStep2:

Step 2: Signing the document
================================

This whole step is carried out in the signing portal. For each signer of the job, you will need to redirect the person to the portal using its associated redirect-URL, typically by responding with a `302 Found` redirect to your user's browser when a request to sign is being made in your system.

A redirect-URL contains a one-time token generated by the signature service, and it is this token that allows the user to read the documents and complete the signing.

Although the resonse you get when creating a new job already contains ready-to-use redirect-URLs, you may as well request a redirect-URL for the signer each time a signing procedure is initiated. This then avoids then need to persist any redirect-URL, as the URL is volatile, and if attempted used multiple time, will be denied access.

..  IMPORTANT::
    **Security related to the one-time token:** To handle the security of this request, the token will only work once. The user will receive a cookie from the signature service when accessing the URL, so that any refresh does not stop the flow. This URL cannot be reused at a later time. The reason we only allow it to be used only once is that URLs can appear in logs, and it will therefore not be safe to reuse.


..  tabs::

    ..  group-tab:: C#

        ..  code-block:: c#

            Uri signerUrl = // resolve applicable signerUrl from created job
            var signerWithRedirectUrl = await directClient
                .RequestNewRedirectUrl(
                    NewRedirectUrlRequest
                        .FromSignerUrl(persistedSignerUrl)
                );
            var redirectUrl = signerWithRedirectUrl.RedirectUrl;
            // redirect the signer's browser to the redirectUrl

    ..  group-tab:: Java

        ..  code-block:: java

            URI signerUrl = // resolve applicable signerUrl from created job
            DirectSignerResponse signerWithRedirectUrl = client
                    .requestNewRedirectUrl(WithSignerUrl.of(signerUrl));
            URI redirectUrl = signerWithRedirectUrl.getRedirectUrl();
            // redirect the signer's browser to the redirectUrl

        See also Javadoc for `DirectSignerResponse <https://javadoc.io/doc/no.digipost.signature/signature-api-client-java/latest/no/digipost/signature/client/direct/DirectSignerResponse.html>`_.

    ..  group-tab:: HTTP

        The ``href`` attribute of the ``signer`` element(s) in the response from creating a new job contains the signer-url for each signer. This URL can be used to request a new redirect-URL.

        Issue a ``POST`` to a signer's ``href`` with the following body:

        .. code-block:: xml

            <direct-signer-update-request xmlns="http://signering.posten.no/schema/v1">
                <redirect-url />
            </direct-signer-update-request>

        The resonse will contain the state for the signer, and with a ``redirect-url`` which should be used to redirect the signer's browser in order to start the signing procedure.

        .. code-block:: xml

            <direct-signer-response xmlns="http://signering.posten.no/schema/v1"
            href="https://api.signering.posten.no/api/123456789/direct/signature-jobs/1/signers/1">
                <personal-identification-number>12345678910</personal-identification-number>
                <redirect-url>
                    https://signering.posten.no#/redirect/cwYjoZOX5jOc1BACfTdhuIPj
                </redirect-url>
            </direct-signer-response>



The user completes the signing and is then returned to the sender's portal via the URL specified by ``completion url``. At the end of this URL, the query parameter ``status_query_token`` will be appended, which you will use later when you ask for the signature job status. If the signer interrupts the signing, or an error occurs, the signer will be sent to the ``rejection-url`` or the ``error-url`` respectively.



.. _directIntegrationStep3:

Step 3: Get status
===================

Status by token
-----------------

The signing process is a synchrounous operation in the direct use case. There is no need to poll for changes to a signature job, as the status is well known to the sender of the job. As soon as the signer completes, rejects or an error occurs, the user is redirected to the respective URLs set in ExitUrls. A :code:`status_query_token` parameter has been added to the url, use this when requesting a status change.

..  tabs::

    ..  group-tab:: C#

        ..  code-block:: c#

            ClientConfiguration clientConfiguration = null; //As initialized earlier
            var directClient = new DirectClient(clientConfiguration);
            JobResponse jobResponse = null; //As initialized when creating signature job
            var statusQueryToken = "0A3BQ54C...";

            var jobStatusResponse =
                await directClient.GetStatus(jobResponse.StatusUrl.Status(statusQueryToken));

            var jobStatus = jobStatusResponse.Status;


    ..  group-tab:: Java

        ..  code-block:: java

            DirectClient client = null; // As initialized earlier
            DirectJobResponse directJobResponse = null; // As returned when creating signature job

            String statusQueryToken = "0A3BQ54C…";

            DirectJobStatusResponse directJobStatusResponse = client
                .getStatus(StatusReference.of(directJobResponse)
                .withStatusQueryToken(statusQueryToken));

    ..  group-tab:: HTTP

        When the signer is sent back to the sender's portal, you will be able to retrieve the status of the job. This is done by sending an ``HTTP GET`` request to the ``status-url`` you got in :ref:`Step 1 <directIntegrationStep1>` where you add the query parameter (``status_query_token``) you got in :ref:`Step 2 <directIntegrationStep2>`.

        If the signature job is placed on a specific queue, then the query parameter ``polling_queue`` must be set to the queue name.

        The response from this request is defined by the ``direct-signature-job-status-response`` element. An example of this response to a successful signing of a job is shown below:

        ..  code:: xml

            <direct-signature-job-status-response xmlns="http://signering.posten.no/schema/v1">
               <signature-job-id>1</signature-job-id>
               <signature-job-status>COMPLETED_SUCCESSFULLY</signature-job-status>
               <status since="2017-01-23T12:51:43+01:00">SIGNED</status>
               <confirmation-url>https://api.signering.posten.no/api/{sender-identifier}/direct/signature-jobs/1/complete</confirmation-url>
               <pades-url>https://api.signering.posten.no/api/{sender-identifier}/direct/signature-jobs/1/pades</pades-url>
            </direct-signature-job-status-response>


.. _directIntegrationStatusByPolling:

Status by polling
-------------------

If you, for any reason, are unable to retrieve status by using the status query token specified above, you may poll the service for any changes done to your organization’s jobs. If the queue is empty, additional polling will give an exception.

..  NOTE::
    For the job to be available in a polling queue, make sure to specify the job's :ref:`directIntegrationSetStatusRetrievalMethod`.

..  tabs::

    ..  group-tab:: C#

        ..  code-block:: c#

            ClientConfiguration clientConfiguration = null; // As initialized earlier
            var directClient = new DirectClient(clientConfiguration);

            // Repeat the polling until signer signs the document, but ensure to do this at a
            // reasonable interval. If you are processing the result a few times a day in your
            // system, only poll a few times a day.
            var change = await directClient.GetStatusChange();

            switch (change.Status)
            {
                case JobStatus.NoChanges:
                    // Queue is empty. Additional polling will result in blocking for a defined period.
                    break;
                case JobStatus.CompletedSuccessfully:
                    // Get PAdES
                    break;
                case JobStatus.Failed:
                    break;
                case JobStatus.InProgress:
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

            // Confirm status change to avoid receiving it again
            await directClient.Confirm(change.References.Confirmation);

            var pollingWillResultInBlock = change.NextPermittedPollTime > DateTime.Now;
            if (pollingWillResultInBlock)
            {
                //Wait until next permitted poll time has passed before polling again.
            }


    ..  group-tab:: Java

        ..  code-block:: Java

            DirectClient client = null; // As initialized earlier

            DirectJob directJob = DirectJob.builder(document, exitUrls, signer)
                    .retrieveStatusBy(StatusRetrievalMethod.POLLING)
                    .build();

            client.create(directJob);

            DirectJobStatusResponse statusChange = client.getStatusChange();

            if (statusChange.is(DirectJobStatus.NO_CHANGES)) {
                // Queue is empty. Must wait before polling again
                Instant nextPermittedPollTime = statusChange.getNextPermittedPollTime();
            } else {
                // Received status update, act according to status
                DirectJobStatus status = statusChange.getStatus();
                Instant nextPermittedPollTime = statusChange.getNextPermittedPollTime();
            }

            client.confirm(statusChange);

    ..  group-tab:: HTTP


        When the signer is sent back to the sender's portal, you will be able to retrieve the status of the signature job. This is done by sending an ``HTTP GET`` request to the ``status url`` you received in :ref:`Step 1 <directIntegrationStep1>`.

        If the signature job is placed on a specific queue, then the query parameter ``polling_queue`` must be set to the queue name.

        The response from this request is defined by the ``direct-signature-job-status-response`` element. An example of this response to a successful signing of a job is shown below:

        ..  code:: xml

            <direct-signature-job-status-response xmlns="http://signering.posten.no/schema/v1">
               <signature-job-id>1</signature-job-id>
               <signature-job-status>COMPLETED_SUCCESSFULLY</signature-job-status>
               <status since="2017-01-23T12:51:43+01:00">SIGNED</status>
               <confirmation-url>https://api.signering.posten.no/api/{sender-identifier}/direct/signature-jobs/1/complete</confirmation-url>
               <pades-url>https://api.signering.posten.no/api/{sender-identifier}/direct/signature-jobs/1/pades</pades-url>
            </direct-signature-job-status-response>

..  TIP::
    As illustrated above, you should always query the :code:`statusChange` to find out when you are allowed to poll for statuses next time.

Step 4: Get signed documents
==============================

..  tabs::

    ..  group-tab:: C#

        ..  code-block:: c#

            ClientConfiguration clientConfiguration = null; //As initialized earlier
            var directClient = new DirectClient(clientConfiguration);
            JobStatusResponse jobStatusResponse = null; // Result of requesting job status

            if (jobStatusResponse.Status == JobStatus.CompletedSuccessfully)
            {
                var padesByteStream = await directClient.GetPades(jobStatusResponse.References.Pades);
            }

    ..  group-tab:: Java

        ..  code-block:: java

            DirectClient client = null; // As initialized earlier
            DirectJobStatusResponse directJobStatusResponse = null; // As returned when getting job status

            if (directJobStatusResponse.isPAdESAvailable()) {
                InputStream pAdESStream = client.getPAdES(directJobStatusResponse.getpAdESUrl());
            }

    ..  group-tab:: HTTP

        In the previous step you got a link to the signed document: ``pades-url``. Do a ``HTTP GET`` on this to download the signed document. For more information on the format of the signed document, see :ref:`signed-documents`.



.. _directIntegrationQueuesMoreInformation:

Specifying queues
===================

An important and necessary feature for organizations using more than one application to create signature jobs through the API. It enables an application to retrieve status changes independent of other applications.

The feature specifies the queue that jobs and status changes for a signature job will occur in. It is used for signature jobs where ``StatusRetrievalMethod == POLLING``. If your organization is using more than one application/integration to access our API, we strongly recommend using a separate queue for each one. This is to ensure that one does not retrieve the others' receipts. This may result in missing status changes for jobs in one of the applications, which in turn will result in a poor user experience. Only use the default queue, i.e. not specifying a queue, when only one of your applications access the Posten signering API.




Delete documents
==================

After receiving a status change, the documents can be deleted as follows:

..  tabs::

    ..  group-tab:: C#

        This is currently not implemented in the C# client. However all contents of non-completed jobs, as well as completed jobs without :ref:`long-term-validation-and-storage` will be deleted automatically in 40 days.

    ..  group-tab:: Java

        ..  code-block:: java

            DirectClient client = // As initialized earlier
            DirectJobStatusResponse jobStatusResponse = // As returned when getting job status
            var deleteDocumentsUrl = jobStatusResponse.getDeleteDocumentsUrl();
            if (deleteDocumentsUrl != null) {
                client.deleteDocuments(jobStatusResponse.getDeleteDocumentsUrl());
            }


    ..  group-tab:: HTTP

        Whenever a job is deletable, the status responses will contain a `delete-documents-url <https://github.com/digipost/signature-api-specification/blob/3.1.0/schema/xsd/direct.xsd#L289>`_ element. Issuing a ``DELETE`` to this URL will delete all document contents from this job.


..  |direkteflytskjema| image:: https://raw.githubusercontent.com/digipost/signature-api-specification/main/integrasjon/flytskjemaer/synkron-maskin-til-maskin.png
    :alt: Flow chart for signing in direct flow


