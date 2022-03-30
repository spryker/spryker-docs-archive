---
title: Setting up a self-signed SSL certificate
description: Learn how to import a self-signed SSL certificate to access your instance via a secure connection.
last_updated: Jun 16, 2021
template: howto-guide-template
originalLink: https://documentation.spryker.com/2021080/docs/setting-up-a-self-signed-ssl-certificate
originalArticleId: 2991edda-38a5-4dd9-b03c-f87b05a32949
redirect_from:
  - /2021080/docs/setting-up-a-self-signed-ssl-certificate
  - /2021080/docs/en/setting-up-a-self-signed-ssl-certificate
  - /docs/setting-up-a-self-signed-ssl-certificate
  - /docs/en/setting-up-a-self-signed-ssl-certificate
  - 6/docs/setting-up-a-self-signed-ssl-certificate
  - 6/docs/en/setting-up-a-self-signed-ssl-certificate
---


This HowTo describes the steps to import a self-signed SSL (Secure Sockets Layer) certificate.

A *self-signed SSL certificate* is an identity certificate that is signed by the same entity whose identity it certificates. Such a certificate is used only for development purposes. For production purposes, we recommend generating a valid SSL certificate signed by an official certification center like [letsEncrypt](https://letsencrypt.org/).

There is a self-signed SSL certificate shipped with Spryker in Docker. It is located in `docker/deployment/default/spryker_ca.crt.` To access your instace via a secure connection, add the certificate to trusted authorities in the host system.

Depending on the operating system, follow the instructions:
* [Setting up a self-signed SSL certificate on Windows](#setting-up-a-self-signed-ssl-certificate-on-windows)
* [Setting up a self-signed SSL certificate on Linux](#setting-up-a-self-signed-ssl-certificate-on-linux)
* [Setting up a self-signed SSL certificate on MacOS](#setting-up-a-self-signed-ssl-certificate-on-macos)

## Setting up a self-signed SSL certificate on Windows
To add `spryker_ca.crt` to trusted authorities in Windows:
1. To open the **Run** window, press **Win+R**.
2. In the **Open** field, enter *mmc* and press **Enter**.
3. Click **Yes** to confirm the action.
4. From the **File** menu, select **Add/Remove Snap-in...**.
{% info_block infoBox %}

Alternatively, press **Ctrl+M** to open the **Add or Remove Snap-ins** window.

{% endinfo_block %}
5. In the **Available snap-ins** list, select **Certificates**.
6. Select **Add >**.
![Add certs](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/add-certs.png)

7. Click **Certificates (local computer)** > **Trusted Root Authorities**.
8. Right-click the **Certificates** folder and select **All Tasks** > **Import**.
9. Select the `spryker_ca.crt` file and click **OK**.

{% info_block warningBox "Verification" %}

Ensure that you can open Yves, Zed, and Glue without warnings via HTTPS.

![HTTPS verification](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/https-verification.png)

{% endinfo_block %}

## Setting up a self-signed SSL certificate on Linux
On Linux, you can add the certificate to trusted authorities only in a browser. Below, you can find instructions for importing the certificate in Google Chrome and Firefox.

### Setting up a self-signed SSL certificate in Google Chrome on Linux
To add `spryker_ca.crt` to trusted authorities in Google Chrome on Linux:
1. Click **More**![google-chrome-more-button](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/chrome-more-button.png).
2. Select **Settings**.
3. On the *Settings* page, go to **Advanced** > **Manage certificates**.
4. Go to the **Authorities** tab.
5. Select **Import**.
6. Select `spryker_ca.crt` and click **Open**.
7. Select **Trust this certificate for identifying websites**.
8. Click **OK** to save the changes.
9. Restart the browser.

{% info_block warningBox "Verification" %}

Ensure that you can open Yves, Zed, and Glue without warnings via HTTPS.
![HTTPS verification](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/https-verification.png)

{% endinfo_block %}

### Setting up a self-signed SSL certificate in Firefox on Linux
To add `spryker_ca.crt` to trusted authorities in Firefox on Linux:

1. Click **Open menu** ![firefox-menu-button](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/firefox-menu-button.png).
2. Select **Options**.
3. On the *Options* page, select **Privacy & Security**.
4. Scroll down to the **Certificates** section.
5. Click **View Certificates**.
6. In the **Authorities** tab, click **Import**.
7. Select `spryker_ca.crt`.
8. Select **Trust this CA to identify websites.**
![Select file in Firefox](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/select-file.png)
9. Click **OK** to save the changes.
{% info_block warningBox "Verification" %}

Ensure that you can open Yves, Zed, and Glue without warnings via HTTPS.
![HTTPS verification](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/https-verification.png)

{% endinfo_block %}

## Setting up a self-signed SSL certificate on MacOS
To add `spryker_ca.crt` to trusted authorities in MacOS:
1. Open Keychain Access.
2. Select **File** > **Import Items**.
3. Select `spryker_ca.crt` and click **Open**.
4. Go to the *Certificates* category.
5. Right-click the *Spryker* certificate and select **Get Info**.
![Get info in Safari and Chrome](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/get-info.png)

6. Open the **Trust** drop-down menu.
7. In the **When using this certificate** drop-down menu, select **Always Trust**.
![Make the certificate trusted](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/always-trust.png)



{% info_block warningBox "Verification" %}

Ensure that you can open Yves, Zed, and Glue without warnings via HTTPS.
![HTTPS verification](https://spryker.s3.eu-central-1.amazonaws.com/docs/Tutorials/HowTos/Docker+HowTos/HowTo+Install+Self-Signed+SSL+Certificates/https-verification.png)

{% endinfo_block %}
