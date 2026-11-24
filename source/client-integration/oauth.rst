.. _oauth-authentication:

Authenticate with OAuth 2.0
****************************

The Posten signering API is part of Digipost's PKI infrastructure, and is a *resource server* on equal terms with the Digipost API. This means you can authenticate with an OAuth client, using the same client and certificate for several Digipost services.

An OAuth client authenticates with mutual TLS (mTLS) towards Digipost mIdP, the machine-to-machine identity provider for the APIs in the Digipost family, and requests an access token. You then call the Posten signering API with this access token as a bearer token.

.. NOTE::
   This page describes the protocol, for those integrating directly against the API. The authentication mechanism is the same as the one described for the Digipost API in the `Digipost API documentation <https://digipost.github.io/digipost-technical-docs/api/oauth.html>`__.

Prerequisites
==============

You need the following from Digipost's self-service portal. See the `Digipost API documentation <https://digipost.github.io/digipost-technical-docs/process/self-service.html>`__ for how to create them.

- The **client ID** from the client details page.
- The **KeyStore** (``.p12`` file) for the certificate the client is bound to, together with its password.
- The **account ID** you have selected as a scope for the client, listed under *Posten signering*.

.. _oauth-environments:

Environments
=============

.. list-table::
   :header-rows: 1
   :widths: 20 40 40

   * - Environment
     - Token endpoint (mIdP)
     - API and ``resource``
   * - Test
     - ``https://midp.difitest.digipost.no/oauth2/token``
     - ``https://api.sign.difitest.digipost.no``
   * - Production
     - ``https://midp.digipost.no/oauth2/token``
     - ``https://api.sign.digipost.no``

.. IMPORTANT::
   These addresses are only for OAuth authentication. With OAuth, the API is reached on its own domain (``api.sign.digipost.no``). If you authenticate with the organization certificate directly over two-way TLS, you must keep using the existing addresses (``api.signering.posten.no`` in production, and ``api.difitest.signering.posten.no`` in the public test environment). An access token is not accepted there, and the organization certificate is not accepted on the OAuth domain.

Requesting an access token
===========================

Send a form-encoded ``POST`` request to the token endpoint of mIdP, over a TLS connection where you present the client certificate. Mutual TLS is required on the token endpoint.

.. list-table::
   :header-rows: 1
   :widths: 25 75

   * - Parameter
     - Value
   * - ``grant_type``
     - ``client_credentials``
   * - ``client_id``
     - The client ID from the self-service portal.
   * - ``scope``
     - One scope, written ``signering:{account id}``, for example ``signering:123456``.
   * - ``resource``
     - The resource indicator of the API you intend to call. See :ref:`oauth-environments`.

A token is issued for one resource server and one account, so you must request one token per scope. The scope for Posten signering always has the resource server name ``signering``. The Digipost API uses ``dpost-api``, so a client with access to both services needs separate tokens for each of them.

Example request
-----------------

..  tabs::

    .. group-tab:: Test

        .. code-block:: sh

            curl -X POST https://midp.difitest.digipost.no/oauth2/token \
              --cert-type P12 --cert certificate.p12:TheSecretPassword \
              -d grant_type=client_credentials \
              -d client_id=your-client-id \
              -d scope=signering:123456 \
              -d resource=https://api.sign.difitest.digipost.no

    .. group-tab:: Production

        .. code-block:: sh

            curl -X POST https://midp.digipost.no/oauth2/token \
              --cert-type P12 --cert certificate.p12:TheSecretPassword \
              -d grant_type=client_credentials \
              -d client_id=your-client-id \
              -d scope=signering:123456 \
              -d resource=https://api.sign.digipost.no

The response contains the access token:

.. code-block:: json

    {
      "access_token": "eyJhbGciOiJQUzI1NiIsInR5cCI6ImF0K2p3dCIsImtpZCI6...",
      "token_type": "Bearer",
      "expires_in": 300
    }

The access token
=================

The access token is a JWT with the following properties:

- The ``aud`` claim is the resource server name from the scope (``signering``), and the ``account_id`` claim is the account ID.
- It is signed with **PS256** (RSASSA-PSS). Anything that validates the signature must support PS256. Some JWT libraries only implement RS256.

The token is short-lived (see ``expires_in``). Cache it and request a new one shortly before it expires, rather than requesting a token for every API request.

Calling the API
================

Send the access token as a bearer token on your API requests:

.. code-block:: text

    Authorization: Bearer <access_token>

The client certificate is only presented to mIdP when requesting the token, not on the requests to the signing API. Requests are sent to the API address for the environment, see :ref:`oauth-environments`. For example, in the public test environment:

.. code-block:: sh

    curl https://api.sign.difitest.digipost.no/api/${orgNumber} \
      -H "Authorization: Bearer ${accessToken}"

The API on this domain has an ordinary, publicly trusted TLS certificate, so no special handling of the server certificate is needed.

Renewing the certificate
=========================

A client registration holds a single certificate thumbprint, not a list. A client therefore cannot have an old and a new certificate valid at the same time.

.. IMPORTANT::
   Create the new certificate and a new client in the self-service portal, move your integration over to the new client ID, and only then remove the old certificate. A client also stops getting tokens the day its certificate expires, so keep an eye on the expiry date on the certificate details page.

Troubleshooting
================

.. list-table::
   :header-rows: 1
   :widths: 30 70

   * - Error
     - Cause
   * - ``invalid_client``
     - The certificate presented in the TLS handshake does not match the thumbprint on the client registration, or the client is not registered.
   * - Signature validation fails
     - The validating library does not support PS256.
   * - Tokens stop being issued
     - The certificate has expired, or it has been revoked or unregistered in the self-service portal.
   * - ``401 Unauthorized`` from the signing API
     - The access token has expired, or was issued for another resource or scope. Request a new token, and check that ``scope`` and ``resource`` are as described above.
