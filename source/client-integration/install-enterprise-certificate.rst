Install enterprise certificate
*******************************

In order to use the client, the enterprise certificate must be set up according to your environment. We currently
support .NET Core, .NET Framework and Java.


.NET Core
==========

Install the certificate
________________________

The path and password to the certificate must be put somewhere safe. For local development with .NET Core we recommend using the `Secret Manager <https://docs.microsoft.com/en-us/aspnet/core/security/app-secrets?view=aspnetcore-2.2&tabs=linux#how-the-secret-manager-tool-works>`_.

Add the following :code:`UserSecretsId` element to your :code:`.csproj` file:

.. code-block:: xml

   <PropertyGroup>
        <TargetFramework>netcoreapp2.1</TargetFramework>
        <UserSecretsId>organization-certificate</UserSecretsId>
   </PropertyGroup>

This means that the element :code:`<user_secrets_id>` in the path will be :code:`organization-certificate`.

From the command line, navigate to the directory where the current .csproj file is located and run the following commands with your own certificate values.

.. code-block:: bash

   dotnet user-secrets set "Certificate:Path:Absolute" "<your-certificate.p12>"
   dotnet user-secrets set "Certificate:Password" "<your-certificate-password>"

Trust the certificate
______________________

In addition to installing the certificate, you must add the certificate to the trust store on the host machine.

.. tabs::

   .. group-tab:: Windows

      Double click the enterprise certificate and choose to install on :code:`Local Machine` or :code:`Current user`. This will install the intermediate and root certificate on the host, which is what we want.

   .. group-tab:: macOS

     #. Open :code:`Keychain Access`
     #. Choose :code:`login` keychain
     #. Use navigation: File - Import items

   .. group-tab:: Linux

      Download the root and intermediate certificates from `Digitaliseringsdirektoratet <https://docs.digdir.no/dpi_sertifikathandtering.html>`_ for your enterprise certificate provider. Note the renaming to have :code:`.crt` ending for :code:`update-ca-certificates`:

      .. code-block:: bash

         sudo cp Buypass_Class_3_Test4_Root_CA.pem /usr/local/share/ca-certificates/Buypass_Class_3_Test4_Root_CA.crt
         sudo cp Buypass_Class_3_Test4_CA_3.pem /usr/local/share/ca-certificates/Buypass_Class_3_Test4_CA_3.crt
         sudo update-ca-certificates



.NET Framework
================

.. NOTE::
   .NET Framework is only supported on the Windows platform.

The following steps will install the certificate in the your certificate store. This should be done on the server where your application will run.

#. Double-click on the actual certificate file (CertificateName.p12)
#. Save the certificate in :code:`Current User` or :code:`Local Machine` and click *Next*
#. Use the suggested filename. *Click Next*
#. Enter password for private key and select *Mark this key as exportable* … *Click Next*
#. Select Automatically select the certificate store based on the type of certificate
#. Click *Next* and *Finish*
#. Accept the certificate if prompted
#. When prompted that the import was successful, click *OK*

.. NOTE::
   If you for some reason are not allowed to store the business certificate with the exportable flag, it can be added to the store using the following script:

   *certutil -p <password> -csp "Microsoft Enhanced RSA and AES Cryptographic Provider" -importpfx <filename> NoExport,AT_SIGNATURE*.

In order to use the certificate you have just installed, the thumbprint of the certificate must be retrieved. It can be done in the following way:

#. Start :code:`mmc.exe` (Press the windows button and type mmc.exe)
#. *Choose File -> Add/Remove Snap-in…* (Ctrl + M)
#. Mark certificate and click *Add >*
#. If the certificate was installed in :code:`Current User` choose :code:`My User Account` and if installed on :code:`Local Machine` choose :code:`Computer Account`, click *Finish* and then *OK*
#. Expand :code:`Certificates` node, select :code:`Personal` and open :code:`Certificates`
#. Double-click on the installed certificate
#. Go to the *Details* tab
#. Scroll down to *Thumbprint*
#. Copy the thumbprint

Java
=====

If you are using the Java client library, there is no need to install the enterprise certificate. It can be loaded directly from file.
