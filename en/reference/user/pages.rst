Dynamic pages
=============
Dynamic pages allows user to create any content via full page layout without any programming knowledge.

.. image:: /images/pages_1.png
    :align: center

In column "Layout" you can see page layout type. To create new page - navigate to "Create new page" menu.

.. image:: /images/pages_2.png
    :align: center

Fields description:

    **Title** - title of the page, this title will be used to identify page in grid and it is also will be printed in html as page title.

    **Url** - page url, this will identify how your page will be accessible via network. Note that you can't define full link (so don't start url with 'http' or '/' symbol).
    Example 1: If you set url as "test" page will be available at address: http://yoursite.com/page/test .
    Example 2: Url is "some-long-page/with/id/1" will be available att address: http://yoursite.com/page/some-long-page/with/id/1 .

    **Description** - page description, will be printed to html page as <meta name="description" content="YOURCONTENT"/>

    **Keywords** - page keywords, will be printed to html page as <meta name="keywords" content="YOURCONTENT"/>

    **Controller** - this is more developer feature, but can be changed by user. Imaging that you have
    PaypalController that performs Paypal checks before page dispatch and WebmoneyController that also performs some
    Webmoney checks before dispatch. And you have dynamic page with widgets, that have some resolved logic depending on controller.
    You can set PaypalController->indexAction to perform Paypal checks at this page. This action (and initialization method) will be performed
    before page rendering.

    **Roles** - set related roles. If nothing selected (or all selected) - all can access this page (view it).
    If selected only one role this means that only that role will be able to view page.

Header and Footer can't be edited, just managed. Home page also can't be removed.

Page management
---------------

Page consist from widgets. Page can have some layout.

.. image:: /images/pages_3.png
    :align: center

At the left of this page is located list of available widgets (Text with blue background is widgets section name,
Core - means that widgets are from Core module, Other - external widgets, etc).

At the right - page layout with widgets.

**Adding new widget** -
Move your mouse cursor on widget from left bar that you want to add to the page. Push left mouth button and drag the widget
to page layout (in any section you want). You can also drag widget from section to section.

**Remove widget** -
Widget can be removed from the page by clicking 'X' link on widget block.

**Edit widget** -
Almost all widgets has their options, to edit them push on 'Edit' link at widget block and you will see a form with options:

.. image:: /images/pages_4.png
    :align: center

After some changes to the page "Save" button became active:

.. image:: /images/pages_5.png
    :align: center

Page layout can be changed:

.. image:: /images/pages_6.png
    :align: center

Note that when you changing layout and some columns will be removed - widgets in that columns will be deleted, too.