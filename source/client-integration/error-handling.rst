Error handling
****************

There are differet forms of exceptions that can occur. Some are more specific than others. All exceptions related to client behavior inherits from :code:`SignatureException`.

..  tabs::

    ..  code-tab:: c#

        try
        {
            //Some signature action
        }
        catch (BrokerNotAuthorizedException notAuthorizedException)
        {
            //Not authorized to perform action. The correct access rights for organization are not set.
        }
        catch (UnexpectedResponseException unexpectedResponseException)
        {
            //UnexpectedResponseException will normally contain an `Error` object giving a more detailed error description. If this error does not exist,
            // you can still get the status code and message.
            var statusCode = unexpectedResponseException.StatusCode;
            var responseMessage = unexpectedResponseException.Message;

            if (unexpectedResponseException.Error != null)
            {
                var errorMessage = unexpectedResponseException.Error.Message;
                var errorType = unexpectedResponseException.Error.Type;
            }
        }
        catch (SignatureException exception)
        {

        }

    ..  code-tab:: java

        try {
            client.confirm(statusChange);
        } catch (BrokerNotAuthorizedException brokerNotAuthorized) {
            // Broker is not authorized to perform action. Contact Digitaliseringsdirektoratet in order to set up access rights.
        } catch (UnexpectedResponseException unexpectedResponse) {
            // The server returned an unexpected response.
            Response.StatusType httpStatusCode = unexpectedResponse.getActualStatus();

            // errorCode and errorMesage will normally contain information returned by the server. May be null.
            String errorCode = unexpectedResponse.getErrorCode();
            String errorMessage = unexpectedResponse.getErrorMessage();
        } catch (SignatureException e) {
            // An unexpected exception was thrown, inspect e.getMessage().
        }


OAuth authentication errors
============================

With :ref:`OAuth authentication <oauth-authentication>`, failures acquiring or validating an access token from Digipost's identity provider (mIdP) are surfaced as their own exception type, a subclass of ``SignatureException``, for example if the token endpoint is unreachable, rejects the client id or scope, or returns a response the client does not understand. In the Java client, this is ``AccessTokenException``. A common cause is a certificate that has expired or been revoked/unregistered in :ref:`Digipost's self-service integrations portal <digipost-self-service>`.

.. TODO::
   Confirm and document the equivalent exception type for the .NET client once its OAuth authentication support is released.
