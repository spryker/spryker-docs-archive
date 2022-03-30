---
title: Comments feature overview
description: Comments feature provides the ability for online owners to add Comments Widget that  allows the customers to leave comments or special requests.
last_updated: Sep 14, 2020
template: concept-topic-template
originalLink: https://documentation.spryker.com/v5/docs/comments-feature-overview
originalArticleId: 7c077738-136f-485b-b48c-79bf9b0a035c
redirect_from:
  - /v5/docs/comments-feature-overview
  - /v5/docs/en/comments-feature-overview
  - /v5/docs/comments
  - /v5/docs/en/comments
---

The *Comments* feature provides the ability for online owners to add the сomments widget. The widget allows the customers to leave comments, special requests or instructions to any entity in the Spryker shop and tag these comments depending on your project specification.

An *entity* is a unit or a component that has some properties and may have relationships with other entities within a system. So, in terms of Spryker Commerce OS, an entity is represented by a Shopping Cart, a Shopping List, a CMS page, etc. It is where the Comments Widget can be located.

As an example of this generic solution, we have implemented Comments on the *Shopping Cart* page.

Comments help multiple customers to have a dialog on the cart contents. How does it work? Let's imagine a situation where you have a company account and three HR members (HR assistant, HR manager, and the head of HR department) who are responsible for purchasing the products for the whole office. They share the same shopping cart. The HR assistant adds the products to the shopping cart and includes a comment requesting to review the shopping cart by an HR manager. With the help of comments, they decide on the final quantity of the products and finalize the shopping cart contents. After the shopping cart is ready, the HR manager adds a comment for the head of the HR department to approve the total price. By means of the conversation in the cart comments, the head of the department makes the latest corrections to the cart's contents and attaches the important comments concerning the shipping of some products to the shopping cart. From now on, the HR assistant can proceed to Checkout. The attached comments will be available on the *Checkout* page and if the order is successfully placed - in the order history.

Thus, the Comments feature enables your B2B customers to effectively communicate and discuss the purchases with colleagues, thereby improve customer satisfaction and speed up the process by avoiding additional communication outside of the context.


## Comments widget
Within the Comments feature, we have created the Comments widget. The widget can be placed on any entity page. In our case, it is the *Shopping Cart* page.

The comment contains the following information:

* Company user's name
* Date when the comment was left
* Contents of the comment
* Comment Tag

Company users can add comments to a shared cart in both Read-only and Full Access permissions. A user can also add a comment before submitting the order, on the *Checkout Summary* page as well as post factum, after the order has been placed, on the *Order History* page:

{% info_block warningBox "Note" %}
When reordering the existing order, the comments attached to the order are not duplicated.
{% endinfo_block %}
When the order with the attached comments is placed, the Back Office user can view it with the comments in the  **Orders** section of the Back Office.

### Comment tags

Every comment may be tagged. *Tags* are keywords associated with the comments. The tags are added to group the comments sharing a similar idea or topic. For example, you may have several comments where colleagues have covered the details on how the order should be delivered, so you may tag these comments with the *Delivery* tag for convenience. Also, in the drop-down menu, you can filter the comments according to tags added.



## Comments on the Storefront
Company users can perform the following actions using the Comments widget on the Storefront:
<details>
<summary markdown='span'>Create and edit comments</summary>

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Mailing+&+Communication/Comments/creating-and-editing-comments.gif)

</details>

<details>
<summary markdown='span'>Remove comments</summary>

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Mailing+&+Communication/Comments/removing-comments.gif)
</details>

<details>
<summary markdown='span'>Tag comments</summary>

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Mailing+&+Communication/Comments/adding-tags.gif)

</details>

<details>
<summary markdown='span'>Filter comments by tags</summary>

![image](https://spryker.s3.eu-central-1.amazonaws.com/docs/Features/Mailing+&+Communication/Comments/filtering-tags.gif)
</details>

{% info_block warningBox "Developer guides" %}

Are you a developer? See [Comments feature walkthrough](/docs/scos/dev/feature-walkthroughs/{{page.version}}/comments-feature-walkthrough.html) for developers.

{% endinfo_block %}
