Changing a signature request
*****************************

Actions that stop a signature request
============================================

If a *terminating action* is performed for a signature request, the request will be terminated and signers who have not yet signed will lose this opportunity. :ref:`The senter will be notified <notifications-for-senders>` that the signature request has been terminated, with a status report describing the action taken.

The different actions that terminate a signature request are:

- A signer rejects the request
- The sender cancels the request
- The request's expiration time has been passed

**Example**

The sender creates a request with three signers. *Signer 1* signs, *signer 2* rejects. If *signer 3* logs into the signature portal after *signer 2*  has rejected, they will *not* see the signature request and will not be able to sign.

Cancellation of a signature request
====================================

Cancellation of a signature request is only relevant for signature requests in portal flow.

A signature request can be cancelled by the sender at any time, as long as the request has not already been completed. Cancelled requests will be made unavailable to signers who have not yet signed.
