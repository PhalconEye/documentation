Navigation
==========
Navigation allows to build menus and breadcrumbs.

Let's look on example:

.. code-block:: php

    <?php

    $navigation = new Navigation();
    $navigation
        ->setItems(
            [
                'index' => [
                    'href' => 'admin/menus',
                    'title' => 'Browse',
                    'prepend' => '<i class="glyphicon glyphicon-list"></i>'
                ],
                1 => [
                    'href' => 'javascript:;',
                    'title' => '|'
                ],
                'create' => [
                    'href' => 'admin/menus/create',
                    'title' => 'Create new menu',
                    'prepend' => '<i class="glyphicon glyphicon-plus-sign"></i>'
                ]
            ]
        );

    $this->view->navigation = $navigation;


setItems method defines items inside navigation. It accepts array of arrays. Index of each array can be used as active item setup.

Let's look on description of all attributes:

.. code-block:: php

    <?php

    $navigation
        ->setItems(
            [
                'index' => [
                    'href' => 'admin/menus',                                                    // Item link.
                    'title' => 'Browse',                                                        // Item title.
                    'target' => '_blank',                                                       // Link "target" attribute.
                    'onclick' => 'alert("");',                                                  // Link "onclick" attribute.
                    'tooltip' => 'Browse Description',                                          // Item tooltip.
                    'tooltip_position' => 'right',                                              // Item tooltip position.
                    'append' => '<i class="glyphicon glyphicon-list"></i>'                      // HTML/text that will be appended after title.
                    'prepend' => '<i class="glyphicon glyphicon-list"></i>',                    // HTML/text that will be prepended before title.
                ],
                1 => [ // just an item,
                    'href' => 'javascript:;',                                                   // Nothing special.
                    'title' => '|'                                                              // Title again.
                ],
                'settings' => [ // type - dropdown
                    'title' => 'Settings',
                    'items' => [                                                                // Dropdown can be defined by present "items" key in item array.
                        'admin/settings' => [
                            'title' => 'System',
                            'href' => 'admin/settings',
                            'prepend' => '<i class="glyphicon glyphicon-cog"></i>'
                        ],
                        'admin/settings/performance' => [
                            'title' => 'Performance',
                            'href' => 'admin/performance',
                            'prepend' => '<i class="glyphicon glyphicon-signal"></i>'
                        ],
                        2 => 'divider',                                                         // Styled divider.
                        'admin/access' => [
                            'title' => 'Access Rights',
                            'href' => 'admin/access',
                            'prepend' => '<i class="glyphicon glyphicon-lock"></i>'
                        ]
                    ]
                ]
            ]
        );

To set some item as active use setActiveItem method, it checks items keys and their 'href' attribute if they are equal - navigation marks it as active.

Navigation Styling
------------------
For navigation customization there are some methods:

.. code-block:: php

    <?php

    $navigation = new Navigation();

    // Set overall list style class (By default applied to <ul> tag).
    $navigation->setListClass('nav nav-categories');

    // Set dropdown item class (Item of parent but with subitems, by default applied to <li> tag).
    $navigation->setDropDownItemClass('dropdown');

    // Set class list inside item (By default applied to <ul> tag).
    $navigation->setDropDownItemMenuClass('dropdown-menu');

    // Drop down item icon, <li>.
    $navigation->setDropDownIcon('<b class="caret"></b>');

    // By default: true. If active - parent of active item will be highlighted (imaging active item of dropdown).
    $navigation->setEnabledDropDownHighlight(true);

    // This content will be prepended to each item inside navigation.
    $navigation->setItemPrependContent('|');

    // This content will be appended to each item inside navigation.
    $navigation->setItemAppendContent('|');