.. _client-configuration:

Create client configuration
****************************

A client configuration includes all organization specific configuration and all settings needed to connect to the correct environment for Posten signering.

..  tabs::

    ..  group-tab:: Java

        The first step is to load the enterprise certificate (virksomhetssertifikat) through the :code:`KeyStoreConfig`. It can be created from a Java Key Store (JKS) or directly from a PKCS12-container, which is the usual format of an enterprise certificate. The latter is the recommended way of loading it if you have the certificate stored as a simple file:

        ..  code-block:: java

            KeyStoreConfig keyStoreConfig;
            try (InputStream certificateStream = Files.newInputStream(Paths.get("/path/to/certificate.p12"))) {
                keyStoreConfig = KeyStoreConfig.fromOrganizationCertificate(
                    certificateStream, "CertificatePassword"
                );
            }

        If you have a Java Key Store file containing the organization certificate, it can be loaded in the following way:

        ..  code-block:: java

            KeyStoreConfig keyStoreConfig;
            try (InputStream certificateStream = Files.newInputStream(Paths.get("/path/to/javakeystore.jks"))) {
                keyStoreConfig = KeyStoreConfig.fromJavaKeyStore(
                        certificateStream,
                        "OrganizationCertificateAlias",
                        "KeyStorePassword",
                        "CertificatePassword"
                );
            }

        When the certificate has been loaded correctly, a :code:`ClientConfiguration` can be initialized. A trust store and service Uri needs to be set to properly connect. Please change the trust store and service Uri in the following example when connecting to our production environment.

        ..  code-block:: java

            KeyStoreConfig keyStoreConfig = null; //As initialized earlier

            ClientConfiguration clientConfiguration = ClientConfiguration.builder(keyStoreConfig)
                    .trustStore(Certificates.TEST)
                    .serviceUri(ServiceUri.DIFI_TEST)
                    .globalSender(new Sender("123456789"))
                    .build();

    ..  group-tab:: C#


        .. NOTE::
           SEID 2.0 enterprise certificates

            If you have a SEID 2.0 enterprise certificate from Buypass, you need to use at least version `8.1.0 <https://github.com/digipost/signature-api-client-dotnet/releases/tag/8.1.0>`_ of the dotnet client library.
            If this is not possible, or you have a SEID 2.0 enterprise certificate from Commfies, you need to disable validation of the enterprise certificate when configuring your client. The certificate will always be validated on our server, so it will not impact
            the security of the request. The client side validation is only there to help identify errors early on.


        ..  code-block:: c#

            const string organizationNumber = "123456789";

            var clientConfiguration = new ClientConfiguration(
                Environment.DifiTest,
                return new X509Certificate2(certificatePath, certificatePassword),
                new Sender(organizationNumber)
            )
            {
                // This is only need it you have a SEID 2.0 certificate, but for some reason cannot use the latest version of the library,
                // or if you have a SEID 2.0 certificate from Commfides
                CertificateValidationPreferences = { ValidateSenderCertificate = false }
            };

        If you stored the `certificatePath` and `certificatePassword` in the Secret Manager, you can read it like this:

        ..  code-block:: none

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


..  NOTE::
    For organizations acting as brokers on behalf of multiple senders, you may specify the sender’s organization number on each signature job. The sender specified for a job will always take precedence over the :code:`globalSender` in :code:`ClientConfiguration`.
