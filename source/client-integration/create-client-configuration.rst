.. _client-configuration:

Create client configuration
****************************

Signering clients support two different types of certificates: enterprise certificates issued by Buypass/Commfides and certificates issued by Digipost. The client library supports both certificate-only authentication over mutual TLS using either certificate type, and OAuth authentication using either certificate type.

.. IMPORTANT::
   OAuth is the recommended way to authenticate going forward, for both enterprise and Digipost issued certificates — plain certificate-only authentication over mutual TLS will be removed in a future version. New integrations should set up OAuth authentication from the start, and existing integrations should plan to migrate. The upgrade is intended to be a simple process for both new and existing certificates, and the client configuration only requires one additional line of code to use OAuth.

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

        The first step is to create a ``KeyStoreConfig`` which loads the certificate that identifies you as a client — either an enterprise certificate from Buypass/Commfides, or one issued by Digipost. The recommended way is to initialize it from a PKCS12-container file, which is the usual format for these certificates:

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

        When the certificate has been loaded correctly, the resulting ``KeyStoreConfig`` is used to create a ``ClientConfiguration``. By default, this certificate is presented directly to the API over mutual TLS on every request — see :ref:`oauth-authentication` below for a recommended alternative.

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


.. _oauth-authentication:

Authenticate with OAuth instead of the organization certificate (recommended)
================================================================================

By default, the certificate configured above is presented directly to the API over mutual TLS on every request. As a recommended alternative, you can instead authenticate via an OAuth 2.0 *client credentials* grant against Digipost's identity provider (mIdP): the certificate is only presented over mTLS when acquiring an access token from mIdP, and the resulting access token is sent as a bearer token on requests to the signing API instead. The certificate's private key is still used for signing the ASiC-E document package (an XAdES signature) either way.

This works the same for either certificate type — an enterprise certificate from Buypass/Commfides, or one issued by Digipost itself.

.. NOTE::
   This is opt-in and fully backwards compatible: if you don't configure it, your existing certificate-only setup is unaffected. It's recommended for all new integrations and upgrades — both because certificate-only authentication over mutual TLS will be removed in a future version, and because it lets you use a certificate issued by Digipost itself instead of a costlier enterprise certificate, and is reusable across other Digipost services (e.g. Digipost's mailbox API).

To use it, set up a certificate and an OAuth client in :ref:`Digipost's self-service integrations portal <digipost-self-service>` to get a *client id* and an *account id*. The actual code change needed is a single additional line when configuring the client:

..  tabs::

  ..  group-tab:: Java

      ..  code-block:: java

          // KeyStoreConfig keyStoreConfig as initialized earlier

          ClientConfiguration clientConfiguration = ClientConfiguration.builder(keyStoreConfig)
                  .serviceEnvironment(ServiceEnvironment.PRODUCTION)
                  .defaultSender(new Sender("123456789"))
                  // the following line is the only addition needed to use OAuth authentication
                  .useOAuth(new ClientId("my-client-id"), Scope.fromAccountId(123456789))
                  .build();

      ``Scope.fromAccountId(..)`` builds the scope from the account id shown in the self-service portal. If you prefer to work with OAuth concepts directly, you can instead specify the scope verbatim with ``new Scope("signering:123456789")`` — both are equivalent.

      The predefined service environments already know their own token endpoint and resource for OAuth, exposed via ``ServiceEnvironment.oAuth()``. A custom environment (e.g. for testing against a stub) can be given these explicitly with ``ServiceEnvironment.withOAuth(URI, URI, Resource)``, or ``withTokenEndpoint(URI)`` to only change the token endpoint.

      .. NOTE::
         For full control over the OAuth request (e.g. non-default parameters), use the ``useOAuth(Function<ServiceEnvironment, OAuthConfiguration>)`` overload instead, which lets you construct the complete ``OAuthConfiguration`` yourself:

         .. code-block:: java

             .useOAuth(env -> new OAuthConfiguration(
                     env.oAuth().tokenEndpoint(),
                     env.oAuth().resource(), // or any custom Resource
                     new ClientId("my-client-id"),
                     new Scope("signering:123456789")))

  ..  group-tab:: C#

      .. TODO::
         The .NET client library does not yet have a released version of this feature. The Java client's equivalent was recently renamed from a JWT-flavored API (``JwtAuthConfig``/``BrokerId``) to an OAuth-flavored one (``ClientId``/``Scope``/``useOAuth(..)``) — the example below is an **assumed** API mirroring that new shape, and must be verified and corrected once the .NET work ships.

      ..  code-block:: c#

          // X509Certificate2 certificate loaded as initialized earlier

          var clientConfiguration = new ClientConfiguration(
              Environment.Production,
              certificate,
              new Sender(organizationNumber)
          )
          {
              OAuth = OAuthConfiguration.UseOAuth(new ClientId("my-client-id"), Scope.FromAccountId(123456789))
          };

How OAuth authentication works
================================

Access tokens are fetched lazily on first use and cached until shortly before they expire. They are requested from the mIdP at the token endpoint given by ``ServiceEnvironment.oAuth().tokenEndpoint()``, for the API at ``ServiceEnvironment.oAuth().signatureServiceRootUrl()`` — both already configured for the predefined environments.

.. IMPORTANT::
   With OAuth, the API is reached on its own domain, separate from the one used for certificate-only authentication, e.g. ``api.sign.digipost.no`` rather than ``api.signering.posten.no`` for production. This domain has an ordinary, publicly trusted TLS certificate, validated against the JVM's default trust store — unlike the certificate-only domain, which uses a special validation of the server's enterprise certificate (checking the Posten Bring organization number). Any ``serverCertificateTrustStrategy(..)`` override you've configured only applies to certificate-only authentication.

Should the API nevertheless answer ``401 Unauthorized``, the cached token is discarded and the request is sent once more with a newly fetched one. This retry happens only once: if the new token is rejected as well, the error is passed on to you.

The access tokens are fetched with a separate HTTP client, as it has to present the client certificate configured above in the TLS handshake against the token endpoint.

.. IMPORTANT::
   Access tokens are cached per built ``ClientConfiguration``, so build it once per certificate/client id and reuse it — along with the clients created from it — rather than building a new one per request.
