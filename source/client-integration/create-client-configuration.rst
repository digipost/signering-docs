.. _client-configuration:

Create client configuration
****************************

Signering-client supports two different types of certificates: enterprise certificates issued by Commfides/Buypass and certificates issued by Digipost.
New integrations should create/manage certificates and clients in :ref:`Nyva <nyva-self-service>`, Digipost's self-service portal. This makes it possible to authenticate with a certificate issued by Digipost itself, instead of an enterprise certificate from Buypass/Commfides. The same Digipost-issued certificate can also be reused across other Digipost services (e.g. the Digipost mailbox API).

Existing flow with enterprise certificates and mTLS are fully supported today, and integrations using older client library versions are unaffected. However, to upgrade to a newer versions of the client library, you need to configure your certificate (both Enterprise- or Digipost issued) in :ref:`Nyva, Digipost's self-service portal <nyva-self-service>` to get a *client id* and a *broker id*. Using these two values, you only need to add one line (`.jwtAuthentication()`) to your ClientConfiguration implementation for the client library to work as before, now using mIdP and JWT instead.

A client configuration includes all organization specific configuration and all settings needed to connect to the correct environment for Posten signering.

.. _enterprise-certificate-auth:

Authenticate with a enterprise certificate (mTLS)
====================================================================

..  tabs::

  ..  group-tab:: C#


      .. NOTE::
         SEID 2.0 enterprise certificates

          If you have a SEID 2.0 enterprise certificate from Buypass, you need to use at least version `8.1.0 <https://github.com/digipost/signature-api-client-dotnet/releases/tag/8.1.0>`_ of the dotnet client library.
          If this is not possible, or you have a SEID 2.0 enterprise certificate from Commfides, you need to disable validation of the enterprise certificate when configuring your client. The certificate will always be validated on our server, so it will not impact
          the security of the request. The client side validation is only there to help identify errors early on.


      ..  code-block:: c#

          const string organizationNumber = "123456789";

          var clientConfiguration = new ClientConfiguration(
              Environment.DifiTest,
              return new X509Certificate2(certificatePath, certificatePassword),
              new Sender(organizationNumber)
          )
          {
              // This is only needed if you have a SEID 2.0 certificate, but for some reason cannot use the latest version of the library,
              // or if you have a SEID 2.0 certificate from Commfides
              CertificateValidationPreferences = { ValidateSenderCertificate = false }
          };

      If you stored the `certificatePath` and `certificatePassword` in the Secret Manager, you can read it like this:

      ..  code-block:: c#

          var pathToSecrets = $"{System.Environment.GetEnvironmentVariable("HOME")}/.microsoft/usersecrets/enterprise-certificate/secrets.json";
          _logger.LogDebug($"Reading certificate details from secrets file: {pathToSecrets}");

          var fileExists = File.Exists(pathToSecrets);
          if (!fileExists)
          {
              _logger.LogDebug($"Did not find file at {pathToSecrets}");
          }

          var certificateConfig = File.ReadAllText(pathToSecrets);
          var deserializeObject = JsonConvert.DeserializeObject<Dictionary<string, string>>(certificateConfig);

          deserializeObject.TryGetValue("Certificate:Path:Absolute", out var certificatePath);
          deserializeObject.TryGetValue("Certificate:Password", out var certificatePassword);

          _logger.LogDebug("Reading certificate from path found in secrets file: " + certificatePath);

          return new X509Certificate2(certificatePath, certificatePassword, X509KeyStorageFlags.Exportable);


      For integrations acting as brokers on behalf of multiple senders, you may specify the sender’s organization number on each signature job. The sender specified for a job will always take precedence over the ``globalSender`` in ``ClientConfiguration``.

      ..  NOTE::

          TLS 1.2 must be enabled to connect to Posten signering. If this is not the case, please set security protocol using the following statement:
          ``ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;``. If the protocol is not enabled, please refer to the following `Microsoft Documentation for enabling TLS 1.2 <https://docs.microsoft.com/en-us/sccm/core/plan-design/security/enable-tls-1-2>`_.


  ..  group-tab:: Java

        The first step is to create a ``KeyStoreConfig`` which loads the enterprise certificate that identifies you as a client. The recommended way is to initialize it from a PKCS12-container file, which is the usual format of an enterprise certificate:

        ..  code-block:: java

            KeyStoreConfig keyStoreConfig;
            try (InputStream p12Stream = Files.newInputStream(Paths.get("/path/to/certificate.p12"))) {
                keyStoreConfig = KeyStoreConfig.fromOrganizationCertificate(
                        p12Stream, "CertificatePassword"
                );
            }


        Alternatively, if you use Java Key Store files for your certificates, it can be loaded in the following way:

        ..  code-block:: java

            KeyStoreConfig keyStoreConfig;
            try (InputStream jksStream = Files.newInputStream(Paths.get("/path/to/keystore.jks"))) {
                keyStoreConfig = KeyStoreConfig.fromJavaKeyStore(
                        jksStream,
                        "OrganizationCertificateAlias",
                        "KeyStorePassword",
                        "CertificatePassword"
                );
            }

        When the certificate has been loaded correctly, the resulting ``KeyStoreConfig`` is used to create a ``ClientConfiguration``.

        If not explicitly configured, a ``ClientConfiguration`` is specified to use the production API, so you likely want to specify which service environment you want to integrate with, to make sure you connect to ``ServiceEnvironment.STAGING`` when your application runs in any test environment, and ``ServiceEnvironment.PRODUCTION`` for your production environment.

        ..  code-block:: java

            // KeyStoreConfig keyStoreConfig as initialized earlier

            ClientConfiguration clientConfiguration = ClientConfiguration.builder(keyStoreConfig)
                    .serviceEnvironment(ServiceEnvironment.STAGING) // or ServiceEnvironment.PRODUCTION
                    .defaultSender(new Sender("123456789")) // optional, can be set per signature job
                    .httpProxyHost("proxy.host", 3128)      // if connecting through a proxy host
                    .build();

        For integrations acting as brokers on behalf of multiple senders, you may specify the sender’s organization number on each signature job. The sender specified for a job will always take precedence over any ``defaultSender`` specified in ``ClientConfiguration``.

        This should be sufficient configuration for most API integration cases, but feel free to explore the other options available in `ClientConfiguration.Builder <https://javadoc.io/doc/no.digipost.signature/signature-api-client-java/7.0.1/no/digipost/signature/client/ClientConfiguration.Builder.html>`_.


.. _jwt-authentication:

Authenticate with Digipost certificate (JWT via mIdP)
====================================================================

Digipost issued certificates authenticate via an OAuth 2.0 *client credentials* grant against Digipost's identity provider (mIdP), rather than presenting the certificate directly to the signing API over mutual TLS. Your certificate is only presented over mTLS when acquiring an access token from mIdP; the resulting access token is then sent as a bearer token on requests to the Signing API.

The new JWT flow removes the need for the certificate via mTLS when making requests to the API, but the certificate's private key is still used for signing the ASiC-E document package (an XAdES signature) regardless of which authentication method used.

Configure a `JwtAuthConfig` with your client ID and the client certificate (as a `.p12` keystore) used for the mutual-TLS handshake against the token endpoint. The token endpoint defaults to the production one, so it only has to be set for other environments.

..  tabs::

  ..  group-tab:: Java

      ..  code-block:: java

          The first step is to create a ``KeyStoreConfig`` which loads the certificate that identifies you as a client. The recommended way is to initialize it from a PKCS12-container file, which is the usual format of a certificate:

          ..  code-block:: java

              KeyStoreConfig keyStoreConfig;
              try (InputStream p12Stream = Files.newInputStream(Paths.get("/path/to/certificate.p12"))) {
                  keyStoreConfig = KeyStoreConfig.fromOrganizationCertificate(
                          p12Stream, "CertificatePassword"
                  );
              }

          Alternatively, if you use Java Key Store files for your certificates, it can be loaded in the following way:

          ..  code-block:: java

              KeyStoreConfig keyStoreConfig;
              try (InputStream jksStream = Files.newInputStream(Paths.get("/path/to/keystore.jks"))) {
                  keyStoreConfig = KeyStoreConfig.fromJavaKeyStore(
                          jksStream,
                          "OrganizationCertificateAlias",
                          "KeyStorePassword",
                          "CertificatePassword"
                  );
              }

          When the certificate has been loaded correctly, the resulting ``KeyStoreConfig`` is used to create a ``ClientConfiguration``.


          // KeyStoreConfig keyStoreConfig loaded from your Digipost-issued certificate

          ClientConfiguration clientConfiguration = ClientConfiguration.builder(keyStoreConfig)
                  .serviceEnvironment(ServiceEnvironment.PRODUCTION)
                  .defaultSender(new Sender("123456789"))
                  // the following config line is the only addition/change needed specifically for OAuth/JWT authentication
                  .jwtAuthentication(JwtAuthConfig.forClient("736634b1-cac1-4499-bf02-a84869586b2b", BrokerId.of("123")))
                  .build();

      The predefined service environments already know their own mIdP token endpoint. A custom environment (e.g. for testing against a stub) can be given one explicitly with ``ServiceEnvironment.withTokenEndpoint(URI)``.

  ..  group-tab:: C#

      .. TODO::
         // TODO

      ..  code-block:: c#

          // X509Certificate2 certificate loaded from your Digipost-issued certificate,

          var clientConfiguration = new ClientConfiguration(
              Environment.Production,
              certificate,
              new Sender(organizationNumber)
          )
          {
              JwtAuthentication = JwtAuthConfig.ForClient("my-client-id", BrokerId.Of("my-broker-id"))
          };

Access tokens are fetched lazily on first use and cached until shortly before they expire. They are requested from the mIdP at `ServiceEnvironment.tokenEndpointUrl` for the API given by `ServiceEnvironment.serviceRootUrl` which is already configured for the given environments.

Should the API nevertheless answer `401 Unauthorized`, the cached token is discarded and the request is sent once more with a newly fetched one. Requests are tried only more: if the new token is rejected as well, the error is passed on to you.

The access tokens are fetched with a separate HTTP client, as it has to present the client certificate configured above in the TLS handshake against the token endpoint.
