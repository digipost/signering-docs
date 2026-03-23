Debugging
************


curl
==============================
In order to isolate where an integration problem is located, it can be helpful to eliminate any custom runtimes and environment specific aspects, and use a standard tool, configured with applicable keys and certificates, and try to communicate with the API. The following guide will use `curl <https://curl.se/>`_ |curl-binaries|_, together with the `openssl <https://www.openssl.org/>`_ |openssl-binaries|_ tool, which are already readily available on many systems.


Prepare your enterprise certificate
--------------------------------------
To instruct curl to use a client certificate (both the private and public key), it must be available non-encrypted in the `PEM <https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail>`_ format. You likely have your enterprise certificate as an entry in a keystore file, typically a :code:`.p12`-file (`PKCS#12 <https://en.wikipedia.org/wiki/PKCS_12>`_). If you have your enterprise certificate in another format than :code:`.p12`, you need to figure out how you can extract your certificate to a PEM-file.


We will use `openssl` to extract the key entry to PEM format. You need to have the following at hand:

- the keystore file with your enterprise certificate as a filepath, `keystore.p12` is assumed below
- password to read the keystore file (and possibly the particular key entry)

Run the following two commands to extract the public certificate and private key from your enterprise certificate into separate PEM files. You will be prompted for the password:

.. code-block:: sh

    # Extract public certificate chain
    openssl pkcs12 --noenc --in keystore.p12 --out publicCertificate.pem --nokeys

    # Extract the private key, ensure this file is kept private at all times
    openssl pkcs12 --noenc --in keystore.p12 --out privateKey.pem --nocerts


Issue a request to the API
-----------------------------------

With your enterprise certificate available in the files :code:`publicCertificate.pem` and :code:`privateKey.pem`, you should now be able to establish API communication with the Posten signering API.

Substitute :code:`${orgNumber}` with the organization number your certificate is issued to. You can also use an organization number you are authorized to send *on behalf of*.

..  tabs::

    .. group-tab:: Using a test certificate

        .. code-block:: sh

            curl https://api.difitest.signering.posten.no/api/${orgNumber} \
              --cert publicCertificate.pem \
              --key privateKey.pem \
              --insecure

    .. group-tab:: Using a production certificate

        .. code-block:: sh

            curl https://api.signering.posten.no/api/${orgNumber} \
              --cert publicCertificate.pem \
              --key privateKey.pem \
              --insecure

If you need to view more details about the TLS handshake process, supply the :code:`--verbose` flag.

.. NOTE::

    **Why the** :code:`--insecure` **flag?** This flag turns off standard TLS validation of the certificate used by the server, specifically disabling the host name validation. The reason for this is our API uses an enterprise certificate as its *server* certificate, and it is not issued to any specific domain name. :code:`curl` will not accept the API's certificate unless this flag is set. An actual integration should do proper validation of the server certificate when establishing the TLS connection.


Responses
^^^^^^^^^^^^^^^^^^

If a TLS connection is established (you use an appropriate enterprise certificate), the server will respond accordingly depending on whether your request operates as one of:

..  tabs::

    .. group-tab:: Sender

        .. code-block:: text

            You are [the organization number your certificate is issued to]

        This means the organization number is authorized to access the API. The request URL contains the same organization number as the certificate is issued to, and you have access to the API.

    .. group-tab:: Broker

        .. code-block:: text

            You are [the organization number your certificate is issued to],
            operating on behalf of [organization indicated in the request URL]

        This means the organization number your certificate is issued to is authorized to access the API *on behalf of* the other organization number. The request URL contains another organization number than your certificate is issued to, and authorization is appropriately set up in Posten signering to allow you to integrate on behalf of the organization.


Error responses
^^^^^^^^^^^^^^^^^^^^^

Your certificate may be accepted, and TLS connection is established, but may still be denied access because the organization number of your certificate may be missing relevant authorization to access the API.


..  tabs::

    .. group-tab:: Not allowed API access

        Your enterprise certificate has been successfully validated as authentic, but the organization number the certificate is issued to has not been granted access to the API.

        .. code-block:: xml

            <error>
              <error-code>NOT_AUTHORIZED</error-code>
              <error-message>
                API authorization request for [organization number], authenticated using certificate
                  OID.2.5.4.97=NTRNO-[organization number], CN=Your Organization, (...)
                  valid from 2024-11-01T12:00:45Z to 2027-11-01T22:59:00Z,
                  serial-number: xyz123abc456,
                issuer: CN=Buypass Class 3 Test4 CA G2 ST Business, O=Buypass AS,
                  OID.2.5.4.97=NTRNO-983163327, C=NO
                is not authorized to access this system
              </error-message>
              <error-type>CLIENT</error-type>
            </error>

        (Namespaces and other XML-related formalities omitted for brevity)

    .. group-tab:: Unauthorized broker

        Your enterprise certificate has been successfully validated as authentic, but the organization number the certificate is issued to has not been authorized to use the API on behalf of the organization number in the request URL.

        .. code-block:: xml

            <error>
              <error-code>BROKER_NOT_AUTHORIZED<error-code>
              <error-message>
                Broker «[organization number], authenticated using certificate
                  OID.2.5.4.97=NTRNO-[organization number], CN=Your Organization, (...)
                  valid from 2024-11-01T12:00:45Z to 2027-11-01T22:59:00Z, 
                  serial-number: xyz123abc456,
                issuer: CN=Buypass Class 3 Test4 CA G2 ST Business, O=Buypass AS,
                  OID.2.5.4.97=NTRNO-983163327, C=NO»
                is not authorized to send on behalf of «[organization number from request URL]»
              </error-message>
              <error-type>CLIENT</error-type>
            </error>

        (Namespaces and other XML-related formalities omitted for brevity)

    .. group-tab:: Unknown certificate

        If your certificate was not accepted for establishing the TLS connection, an error like this will be issued by :code:`curl`:

        .. code-block:: text

            curl: (56) LibreSSL SSL_read: LibreSSL/3.3.6: error:1404C416:SSL
            routines:ST_OK:sslv3 alert certificate unknown, errno 0

        You need to check the certificate you are using, and verify it is indeed a :ref:`proper enterprise certificate <buyEnterpriseCertificate>`, and you are using the certificate applicable for the environment you are trying to reach, i.e. test certificates are used for the API in our public test environment, and your production certificate is used for the API in production at :code:`api.signering.posten.no`.



If you are missing authorization for the API, please `contact us <https://signering.posten.no/virksomhet/api>`_.






------------------------------------------------------------------------------------------------------------


.NET Core
==========

Enabling logging
----------------

The client library has the ability to log useful information that can be used for debug purposes. To enable logging, supply the :code:`Direct` or :code:`Portal` client with an implementation of :code:`Microsoft.Extensions.Logging.ILoggerFactory`. This is Microsoft's own logging API, and allows the user to chose their own logging framework.

Enabling logging on level :code:`DEBUG` will output positive results of requests and worse, :code:`WARN` only failed requests or worse, while :code:`ERROR` will only occur on failed requests to create a signature job. These loggers will be under the :code:`Digipost.Signature.Api.Client` namespace.

Implementing using NLog
^^^^^^^^^^^^^^^^^^^^^^^^

There are numerous ways to implement a logger, but the following examples will be based on `NLog documentation <https://github.com/NLog/NLog.Extensions.Logging/wiki/Getting-started-with-.NET-Core-2---Console-application>`_.

#. Install the Nuget-packages :code:`NLog`, :code:`NLog.Extensions.Logging` and :code:`Microsoft.Extensions.DependencyInjection`.
#. Create a *nlog.config* file. The following is an example that logs to file and to console:

..  code-block:: xml

    <?xml version="1.0" encoding="utf-8"?>

    <!-- XSD manual extracted from package NLog.Schema: https://www.nuget.org/packages/NLog.Schema-->
    <nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd" xsi:schemaLocation="NLog NLog.xsd"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          autoReload="true"
          internalLogFile="c:\temp\console-example-internal.log"
          internalLogLevel="Info">
        <!-- the targets to write to -->
        <targets>
            <!-- write logs to file -->
            <target xsi:type="File"
                    name="fileTarget"
                    fileName="/logs/signature-api-client-dotnet/signature-api-client-dotnet.log"
                    layout="${date}|${level:uppercase=true}|${message} ${exception}|${logger}|${all-event-properties}"
                    archiveEvery="Day"
                    archiveNumbering="Date"
                    archiveDateFormat="yyyy-MM-dd"/>
            <!-- write logs to console -->
            <target xsi:type="Console"
                    name="consoleTarget"
                    layout="${date}|${level:uppercase=true}|${message} ${exception}|${logger}|${all-event-properties}" />
        </targets>

        <!-- rules to map from logger name to target -->
        <rules>
            <logger name="*" minlevel="Trace" writeTo="fileTarget,consoleTarget"/>
        </rules>
    </nlog>


3. In your application, do the following to create a logger and supply it to the client:

..  code-block:: c#

    private static IServiceProvider CreateServiceProviderAndSetUpLogging()
    {
        var services = new ServiceCollection();

        services.AddSingleton<ILoggerFactory, LoggerFactory>();
        services.AddSingleton(typeof(ILogger<>), typeof(Logger<>));
        services.AddLogging((builder) => builder.SetMinimumLevel(LogLevel.Trace));

        var serviceProvider = services.BuildServiceProvider();
        SetUpLoggingForTesting(serviceProvider);

        return serviceProvider;
    }

    private static void SetUpLoggingForTesting(IServiceProvider serviceProvider)
    {
        var loggerFactory = serviceProvider.GetRequiredService<ILoggerFactory>();

        loggerFactory.AddNLog(new NLogProviderOptions {CaptureMessageTemplates = true, CaptureMessageProperties = true});
        NLog.LogManager.LoadConfiguration("./nlog.config");
    }

    static void Main(string[] args)
    {
        ClientConfiguration clientConfiguration = null;
        var serviceProvider = CreateServiceProviderAndSetUpLogging();
        var client = new PortalClient(clientConfiguration, serviceProvider.GetService<ILoggerFactory>());
    }


Request and response logging
-------------------------------

For initial integration and debugging purposes, it can be useful to log the actual request and response going over the wire. This can be enabled by doing the following:

Set the property :code:`ClientConfiguration.LogRequestAndResponse = true`.

..  CAUTION::
    Enabling request logging should never be used in a production system. It will severely impact the performance of the client.

Logging of document bundle
----------------------------

Logging of document bundle can be enabled via the :code:`ClientConfiguration`:

..  code-block:: c#

    var clientConfiguration = new ClientConfiguration(Environment.DifiTest, "3k 7f 30 dd 05 d3 b7 fc...");
    clientConfiguration.EnableDocumentBundleDiskDump("/directory/path/for/bundle/disk/dump");

..  NOTE::
    Remember to only set the directory to save the disk dump. A new zip file will be placed there for each created signature job.

If you have special needs for the bundle other than just saving it to disk, add your own bundle processor to :code:`ClientConfiguration.DocumentBundleProcessors`.



----------------------------------------------------------------------------------------------------------------------



Java
======

Request and response logging
-------------------------------


..  CAUTION::
    Enabling request logging should never be used in a production system. It will impact the performance of the client.

You may configure the client library to log HTTP requests and responses by calling :code:`.enableRequestAndResponseLogging()` when creating the client's configuration. You may configure the logger :code:`no.digipost.signature.client.http.requestresponse` in order to customize logging. It must be set to at least :code:`INFO` to write anything to the log.

Writing document bundle to disk
----------------------------------

You may configure the client library to write a ZIP file with the document bundle by calling :code:`.enableDocumentBundleDiskDump(Path)` when creating the client's configuration.

The `Path parameter <https://docs.oracle.com/javase/7/docs/api/java/nio/file/Path.html>`_ is the directory to where the files will be written. This directory *must* exists as the client library won't try creating it.

If you have needs for the document bundle other than just saving it to disk, add your own document bundle processor by calling :code:`.addDocumentBundleProcessor(…)` with your own :code:`DocumentBundleProcessor` when creating the client's configuration.





..  |openssl-binaries| image:: /images/opticon-download-16.svg
    :alt: openssl binaries
..  _openssl-binaries: https://github.com/openssl/openssl/wiki/Binaries
..  |curl-binaries| image:: /images/opticon-download-16.svg
    :alt: curl binaries
..  _curl-binaries: https://curl.se/download.html
