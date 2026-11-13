.. _digipost-self-service:

Get Digipost issued certificate
*************************************************************

Digipost's self-service integrations portal is shared across all Digipost services, including Posten signering. It's where you obtain a Digipost issued certificate, and where you create the OAuth client that gives you the *client id* and *account id* needed for :ref:`OAuth authentication <oauth-authentication>`.
Contact the sales team at Digipost to get access to the client authority and register your client. More information can be found in the `Digipost API Documentation <https://digipost.github.io/digipost-technical-docs>`_.

More information can be found in the `Digipost API Documentation <https://digipost.github.io/digipost-technical-docs/>`_.

.. IMPORTANT::
   Enterprise certificates from Buypass/Commfides purchased as described in :ref:`buyEnterpriseCertificate` keep working as previously, authenticating directly against the API — the self-service portal is not required for this. It's where you set up :ref:`OAuth authentication <oauth-authentication>` for either an existing enterprise certificate or a new Digipost-issued one, which is opt-in today but the recommended way to authenticate going forward: certificate-only authentication over mutual TLS will be removed in a future version. This guide covers both creating a new Digipost issued certificate and registering an existing enterprise certificate.

Logging in
======================

Log in with BankID or Buypass. Both meet the highest security level, which is required because a logged-in user can create certificates and machine-to-machine integrations on behalf of an organization. Select which organization to manage — you'll only see organizations you're granted access to.

The dashboard has two sections: **Certificates** and **Clients**.

Certificates
======================

Certificates are used to authenticate against Digipost's identity provider (mIdP) using mTLS to obtain access tokens. A certificate can be shared by several clients, so you don't need one per client.

Select **New certificate**, and choose between:

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Option
     - Description
   * - Digipost-generated certificate
     - Digipost generates the key and a KeyStore (``.p12`` file) for you.
   * - Upload your own certificate
     - Register the public part of an enterprise certificate you already have from Buypass/Commfides.

.. IMPORTANT::
   If you use a Digipost-generated certificate, the KeyStore (``.p12`` file) can only be downloaded immediately after the certificate is created. If you navigate away without downloading it, the private key is lost and you have to create a new certificate.

You are responsible for storing the resulting ``.p12`` file and its password securely, the same way as for an enterprise certificate.

Clients
==========

An OAuth client gives a system access to the accounts you choose, on behalf of the organization. Each client is tied to one certificate and to a set of scopes.

Select **New client** and fill in:

.. list-table::
   :header-rows: 1
   :widths: 25 75

   * - Field
     - Description
   * - Display name
     - Shown in the client overview.
   * - Select certificate
     - The certificate the client will authenticate with. Only certificates that are not revoked can be selected.
   * - Select scopes
     - The accounts the client may act on behalf of, grouped by application. Choose the account(s) grouped under **Posten signering** — each one becomes the **account id** passed to ``Scope.fromAccountId(..)`` when :ref:`creating the client configuration <oauth-authentication>`.

After creation, the client details page shows the **client id** (with a copy button), the certificate it uses, and its selected scopes. There is no client secret: the client authenticates with the certificate you selected, so what your integration needs is the client id and the private key belonging to that certificate.

Renewing a certificate
==========================

.. IMPORTANT::
   A client registration holds a single certificate thumbprint, not a list, so a client cannot have both an old and a new certificate valid at the same time. Create the new certificate and a new client there, move your integration over to the new client id, and only then remove the old certificate. A client also stops getting tokens the day its certificate expires, so keep track of the expiry date shown on the certificate details page.

Troubleshooting
===================

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Error
     - Cause
   * - ``invalid_client``
     - The certificate presented in the TLS handshake doesn't match the thumbprint on the client registration, or the client isn't registered.
   * - Tokens stop being issued
     - The certificate has expired, or has been revoked (Digipost-generated) or unregistered (Buypass/Commfides) there.
