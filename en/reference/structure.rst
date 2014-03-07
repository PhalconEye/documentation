CMS Structure
=============

Let's look on project structure...


.. code-block:: php

    .
    ├── app
    │   ├── config
    │   │   ├── development
    │   │   └── production
    │   ├── engine
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
    │   ├── libraries
    │   ├── modules
    │   │   ├── Core
    │   │   │   ├── Api
    │   │   │   ├── Assets
    │   │   │   ├── Command
    │   │   │   ├── Controller
    │   │   │   ├── Form
    │   │   │   ├── Helper
    │   │   │   ├── Model
    │   │   │   ├── View
    │   │   │   └── Widget
    │   │   └── User
    │   │       ├── Controller
    │   │       ├── Form
    │   │       ├── Helper
    │   │       ├── Model
    │   │       ├── View
    │   │       └── Widget
    │   ├── plugins
    │   ├── var
    │   │   ├── cache
    │   │   │   ├── annotations
    │   │   │   ├── languages
    │   │   │   ├── metadata
    │   │   │   └── view
    │   │   ├── logs
    │   │   └── temp
    │   └── widgets
    └── public
        ├── assets
        └── themes


As you see we can separate our project on two logic parts:

.. toctree::

    structure/app
    structure/public