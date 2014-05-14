Packages
========

Package allows to create modular functionality and share it with community or just use in flexible projects that you can develop.
Package can be exported from system as zip archive and will have manifest file and directory with source code, for example, module:

.. code-block:: text

    .
    ├── package
    │   ├── Assets
    │   ├── Command
    │   ├── Controller
    │   ├── Form
    │   ├── Helper
    │   ├── Model
    │   ├── Plugin
    │   ├── View
    │   ├── Widget
    │   ├── Bootstrap.php
    │   └── Installer.php
    └── manifest.json

Manifest file is required for information about package:

.. code-block:: js

    {
        "type": "module",                               // Package type.
        "name": "blog",                                 // Package unique identity (name).
        "title": "Blog",                                // Package title.
        "description": "PhalconEye Blog module.",       // Package description.
        "version": "0.1.0",                             // Version, allowed two types of versioning: x.x.x and x.x.x.x
        "author": "PhalconEye Team",                    // Who is the alpha and the omega of this package?
        "website": "http:\/\/phalconeye.com\/",         // Website address.
        "dependencies": [                               // Dependencies, allows you to set some relation to other packages, to make sure that your package will work as follows.
            {
                "name": "core",
                "type": "module",
                "version": "0.4.0"
            },
            {
                "name": "user",
                "type": "module",
                "version": "0.4.0"
            }
        ],
        "events": [                                     /*
                                                           Events, that must be attached to EventManager.
                                                           Usage: Namespace\ClassName = eventName
                                                           Note: class Blog\Plugin\SomePluginDir\SomeName must be located in related directory and has correct name and namespace.
                                                        */
            "Blog\\Plugin\\SomePluginDir\\SomeName=dispatch:beforeDispatchLoop",
            "Blog\\Plugin\\Core=init:afterEngine"
        ],
        "widgets": [                                    // Widgets that related to this module.
            {
                "name": "recentblogs",                  // Widget unique name.
                "module": "blog",                       // Widget related to module, it's name.
                "description": "Recent blogs",          // Description of this widget.
                "is_paginated": "1",                    // Flag: is there are any pagination?
                "is_acl_controlled": "1",               // Flag: must be controlled by ACL? Adds multiselect box for widget options, that allows to select allowed roles.
                "admin_form": null,                     /*
                                                           Admin form that can control and display widget options, can be:
                                                           null  - no options or default,
                                                           "action" - widget controller has adminAction method,
                                                           "Some/Namespace/Form/ClassName" - Form class that must be rendered.
                                                        */
                "enabled": true                         // Is enabled.
            }
        ],
        "i18n": [                                       // Localization for this module.
            {                                           // Separated by packages (different languages).
                "info": "PhalconEye Language Package",  // Language package short info.
                "version": "0.4.0",                     // System version.
                "date": "28-Apr-2014 21:10",            // Date of this package.
                "name": "English",                      // Language name.
                "language": "en",                       // Language unique identification.
                "locale": "en_US",                      // Language locale.
                "content": {                            // Content of language (it's translations).
                    "blog": {
                        "Home": "SweetHome"             // Key : Value (Original : Translated).
                    }
                }
            },
            {
                "info": "PhalconEye Language Package",
                "version": "0.4.0",
                "date": "28-Apr-2014 21:10",
                "name": "German",
                "language": "de",
                "locale": "de_DE",
                "content": {
                    "blog": {
                        "Home": "Zuhause"
                    }
                }
            }
        ]
    }


Package Manager
---------------

| Package manager allows you to create, edit, delete, export packages that you are developing.
| As you can see from image, there are several types of package:


.. image:: /images/packages_1.png
   :align: center

Simple "HOW TO":

.. toctree::
    :maxdepth: 1

    packages/manager/create
    packages/manager/upload
    packages/manager/misc
    packages/manager/export



Package types
-------------
There are several types of packages, let's look on each of them:

.. toctree::
    :maxdepth: 1

    packages/modules
    packages/plugins
    packages/widgets
    packages/libraries
    packages/themes
