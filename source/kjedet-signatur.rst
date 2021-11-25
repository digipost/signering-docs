..  _chained-signing:

Chained signing
*****************

In addition to offering :ref:`signing-in-direct-flow` and :ref:`signing-in-portal-flow`, Posten signering has also arranged to support more advanced flows.

Senders who integrate through API and :ref:`use portal flow <signing-in-portal-flow>` can specify a signing sequence for the signers. When all the signers in a group have signed, the request will be available to the next group. A group of signers is everyone that has the same sequence (:code:`order`) in the API and can consist of one or more signers who are to sign in parallel.

..  TIP::
    For chained signature requests, the activation time for the *first group* applies.

Example
_________

Chained signing may be desired in several cases. We can take a real estate agent as an example. A real estate agent should only need to spend time on signing after the buyer of the property has signed. This will save time and make sense, since the real estate agent cannot sign until the buyer has signed. By setting the buyer to have :code:`order=0` and the seller to have :code:`order=1` this will be achieved.

..  TIP::
    In the event of chained signing, the request will be available to all parties for the same length of time. In the example above, this means that if the lifetime of the signature request is set to 1 week, and the buyer signs after 3 days, the real estate agent will thereafter have 1 week to sign. The last day on which the real estate agent can sign is therefore 10 days after the date of creation (3+7 days).

Terminating actions for chained signature requests
_______________________________________________________

A terminating action for a chained signature request will result in the request being terminated for all signers who have not yet signed, including the signers to whom the request has not yet been made available.

If a signer in the first group rejects the request or the signing deadline expires, the request will never be made available to the signers in the subsequent groups and the sender will be notified that the request has been completed with failed status.
