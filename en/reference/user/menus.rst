Menus
=====

To add a menu click "Create new menu" from the top navigation and give it some unique name.
Like in every CMS menus consist of menu items, which can be standalone items or other nested menus.

To manage menu items click "Manage" link from actions column:

.. image:: /images/menus_1.png
    :align: center

Use drag and drop if you need to re-arrange their order.
Each menu item can have its own nested items creating a sub-menu tree structure.
PhalconEye does not limit the depth of nesting! Feel free to create as complicated tree as you need.

Adding and editing items
------------------------

.. image:: /images/menus_2.png
    :align: center

Fields description:

    **Title** - name of the menu item.

    **Target** - this is HTML link attribute "target" which defines click behaviour.

    **Select url type** - switch between an absolute (direct) url or link to one of CMS pages.

    **Url** - absolute (direct) link (shown only if url type above is "Url")

    **Page** - start typing name of a page_ , a list of potential options will appear (shown only if url type above is "System page")

    **OnClick** - this is a html attribute - javascript code, which will be executed once the item is clicked

    **Tooltip** - optional tooltip text for the item.

    **Tooltip position** - defines position of the tooltip message: top, left, right, bottom.

    **Select icon** - optionally you can select an image for the item (icon).
    Note: The icon will not be re-sized so be careful when choosing big images.

    **Icon position** - defines alignment of the icon against item's Title (either Left or Right)

    **Languages** - defines the target languages_ for the item on which it will be visible.

    **Roles** - select target Roles_ for the item.
    If any Role is chosen the item will be restricted only to users who belong to the Role

    **Is Enabled** - whether or not the item should be visible

.. _page: pages.html
.. _Roles: roles.html
.. _languages: languages.html