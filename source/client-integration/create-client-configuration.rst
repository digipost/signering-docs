.. _client-configuration:

Create client configuration
****************************

A client configuration includes all organization specific configuration and all settings needed to connect to the correct environment for Posten signering.

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
