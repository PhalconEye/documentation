CMS Structure
=============

Let's look on project structure...


.. code-block:: text

    PhalconEye
    ├── app                                                     // Application source code.
    │   ├── config                                              // Main configuration directory.
    │   │   ├── development
    │   │   └── production
    │   ├── engine                                              // Engine library directory, heart of PhalconEye.
    │   │   ├── Api
    │   │   ├── Asset
    │   │   │   └── Css
    │   │   ├── Behaviour
    │   │   ├── Cache
    │   │   ├── Console
    │   │   │   └── Command
    │   │   ├── Db
    │   │   │   └── Model
    │   │   ├── Exception
    │   │   ├── Form
    │   │   │   ├── Behaviour
    │   │   │   ├── Element
    │   │   │   └── Validator
    │   │   ├── Grid
    │   │   │   ├── Behaviour
    │   │   │   └── Source
    │   │   ├── Helper
    │   │   ├── Package
    │   │   │   ├── Exception
    │   │   │   ├── Model
    │   │   │   └── Structure
    │   │   ├── Plugin
    │   │   ├── Translation
    │   │   ├── View
    │   │   └── Widget
    │   ├── libraries                                           // Directory for packages with type "library", that can be installed.
    │   ├── modules                                             // Directory for "module" packages.
    │   │   ├── Core                                            // Required module: Core.
    │   │   │   ├── Api
    │   │   │   ├── Assets
    │   │   │   ├── Command
    │   │   │   ├── Controller
    │   │   │   ├── Form
    │   │   │   ├── Helper
    │   │   │   ├── Model
    │   │   │   ├── View
    │   │   │   └── Widget
    │   │   └── User                                            // Required module: User.
    │   │       ├── Controller
    │   │       ├── Form
    │   │       ├── Helper
    │   │       ├── Model
    │   │       ├── View
    │   │       └── Widget
    │   ├── plugins                                             // Plugins directory (packages).
    │   ├── var                                                 // This is work directory, contains: logs, cache, packages operation results, languages, etc.
    │   │   ├── cache
    │   │   │   ├── annotations
    │   │   │   ├── languages
    │   │   │   ├── metadata
    │   │   │   └── view
    │   │   ├── logs
    │   │   └── temp
    │   └── widgets                                             // Widgets directory (packages).
    └── public                                                  // Public directory, this directory can be accessed through internet, must be set as www root.
        ├── assets
        └── themes


We can separate project on two logical parts:

.. toctree::
   :maxdepth: 1

   structure/app
   structure/public