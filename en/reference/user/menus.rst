Menus
=====
Menus has menu items. So you can create new menu by clicking to the "Create new menu" from top navigation and by entering the menu name.

To manage items push "Manage" link at actions column on required row:

.. image:: /images/menus_1.png
    :align: center

Here you can manage items. If you want to change their order - just drag it. Each item can have more items. To manage
sub items - push on button "Manage". Nesting depth isn't limited.

Adding or editing item:

.. image:: /images/menus_2.png
    :align: center

Fields description:

    **Title** - item title in menu.

    **Target** - this is css attribute "target" of the link, it defines link behaviour.

    **Select url type** - url can be a direct url or a link to internal page. In second way "Url" field will be hidden and "Page" field will be shown.

    **Url** - (shown only when url type is "Url") direct link.

    **Page** - (shown only when url type is "System page") in that case you will need to start typing the page name, autocomplete will suggest you
    pages. You need to type full page name.

    **OnClick** - this is css attribute, this code will be pasted into onclick attribute of the link.

    **Tooltip** - tooltip text of the menu item, can be a html.

    **Tooltip position** - defines tooltip position: top, left, right, bottom.

    **Select icon** - you can define image to menu item (icon). Image size will be limited only by css, so be careful when choosing big image.

    **Icon position** - define icon position towards menu item text. Works only when icon is selected.

    **Languages** - define in what languages this menu can be shown. If anything selected - available at all languages.

    **Roles** - define what role can view this menu item. If anything selected - everybody can view this menu item.

    **Is Enabled** - this menu item is enabled?