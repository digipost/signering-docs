.. _security-level:

Security level
***************

As a sender, it is possible to specify which security level the signature request should have. This can be 3 or 4, and limits which electronic IDs the signer can use to sign.

The security level also restricts which login methods the signer can use to view the signature request and its details, and begin signing.

..  TIP::
    If no signature type is specified on creating the request, level 4 will be set as default.

Private organizations
=====================

As a private organization, you can only use the highest security level, level 4, and therefore you do not need to consider this.

..  TIP::
    Available methods for logging in and signing are *BankID, BankID mobile phone* and *Buypass*.

Public organizations
=====================
As a public organization, you can choose security level 3 or 4. A signature request at level 4 can only be shown and signed in its entirety with all e-IDs, except MinID, which is security level 3.

If the user is logged in at level 3, they will get a limited view of the signature request, where only *non-sensitive* titles are visible. To view all details of the request, the user will be prompted to log in again, at security level 4. The user will always be guided to the login method required for the request to be signed, to ensure the best possible user experience.

..  TIP::
    The available methods for logging in and signing are *BankID, BankID mobile phone, Buypass id on smart card, Buypass id in mobile* and *Commfides*.
