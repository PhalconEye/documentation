Assets
======

Assets are public files which are bundled with Modules and the CMS itself.
Before we start explaining how these are handled you should understand the difference between public and not-public files.

* "/app" - private folder whose files can not be accessed directly from requests.
* "/public" - public front-end folder which stores Assets and templates.

For example the Blog module has css, less, js files and images which can not be accessed directly because
of their location on the web server (/app/modules/Blog).

Since these files must be available publicly the Assets system was implemented.
It will take the files, merge, minify and copy them over to the public folder, that's it!
You will never need to worry about doing all this on your own.

There is a console command to install the Modules' Assets and compile Theme's less files:

.. code-block:: bash

    php public/index.php assets install

Files will be available under public directory, public/assets:

.. code-block:: text

    public/assets
    ├── css                                                     // All css files from all modules.
    │   ├── blog                                                // Module name.
    │   ├── constants.css                                       // Constants from theme.
    │   ├── core
    │   │   ├── admin
    │   │   │   └── main.css
    │   │   ├── install.css
    │   │   └── profiler.css
    │   ├── theme.css                                           // Main theme file.
    │   └── user
    ├── img                                                     // All images from modules.
    │   ├── blog
    │   ├── core
    │   │   ├── admin
    │   │   │   └── content
    │   │   │       ├── middle_bottom.png
    │   │   │       ├── middle_left_bottom.png
    │   │   │       ├── middle_left.png
    │   │   │       ├── middle.png
    │   │   │       ├── placeholder.png
    │   │   │       ├── right_middle_bottom.png
    │   │   │       ├── right_middle_left_bottom.png
    │   │   │       ├── right_middle_left.png
    │   │   │       ├── right_middle.png
    │   │   │       ├── top_middle_left.png
    │   │   │       ├── top_middle.png
    │   │   │       ├── top_right_middle_left.png
    │   │   │       └── top_right_middle.png
    │   │   ├── grid
    │   │   │   └── filter-clear.png
    │   │   ├── loader
    │   │   │   ├── black.gif
    │   │   │   └── white.gif
    │   │   ├── misc
    │   │   │   ├── icon-chevron-down.png
    │   │   │   └── icon-chevron-up.png
    │   │   ├── pe_logo.png
    │   │   ├── pe_logo_white.png
    │   │   ├── profiler
    │   │   │   ├── bug.png
    │   │   │   ├── close.png
    │   │   │   ├── files.png
    │   │   │   ├── memory.png
    │   │   │   ├── sql.png
    │   │   │   └── time.png
    │   │   └── stripe.png
    │   └── user
    ├── javascript.js                                           // Merged js files. Will be used in production mode.
    ├── js                                                      // All js files, not merged.
    │   ├── blog
    │   ├── core
    │   │   ├── admin
    │   │   │   ├── dashboard.js
    │   │   │   ├── languages.js
    │   │   │   └── menu.js
    │   │   ├── core.js
    │   │   ├── form
    │   │   │   └── remote-file.js
    │   │   ├── form.js
    │   │   ├── i18n.js
    │   │   ├── pretty-exceptions
    │   │   │   ├── js
    │   │   │   │   ├── jquery.scrollTo-min.js
    │   │   │   │   └── pretty.js
    │   │   │   ├── prettify
    │   │   │   │   ├── lang-apollo.js
    │   │   │   │   ├── lang-clj.js
    │   │   │   │   ├── lang-css.js
    │   │   │   │   ├── lang-go.js
    │   │   │   │   ├── lang-hs.js
    │   │   │   │   ├── lang-lisp.js
    │   │   │   │   ├── lang-lua.js
    │   │   │   │   ├── lang-ml.js
    │   │   │   │   ├── lang-n.js
    │   │   │   │   ├── lang-proto.js
    │   │   │   │   ├── lang-scala.js
    │   │   │   │   ├── lang-sql.js
    │   │   │   │   ├── lang-tex.js
    │   │   │   │   ├── lang-vb.js
    │   │   │   │   ├── lang-vhdl.js
    │   │   │   │   ├── lang-wiki.js
    │   │   │   │   ├── lang-xq.js
    │   │   │   │   ├── lang-yaml.js
    │   │   │   │   ├── prettify.css
    │   │   │   │   └── prettify.js
    │   │   │   └── themes
    │   │   │       ├── default.css
    │   │   │       ├── minimalist.css
    │   │   │       └── night.css
    │   │   ├── profiler.js
    │   │   └── widgets
    │   │       ├── autocomplete.js
    │   │       ├── ckeditor.js
    │   │       ├── grid.js
    │   │       └── modal.js
    │   └── user
    └── style.css                                               // Merged css files. Used in production mode.

To install assets from the code:

.. code-block:: php

    <?php

    $assetsManager = new Manager($this->getDI(), false);

    // Install assets, using theme directory.
    $assetsManager->installAssets(PUBLIC_PATH . '/themes/' . Settings::getSetting('system_theme'));

    // First parameter - refresh assets, this means that old will be removed, new - added.
    // If first parameter is true - second is required (theme directory).
    $assetsManager->clear(true, PUBLIC_PATH . '/themes/' . Settings::getSetting('system_theme'));

    // Get assets collections for JS or CSS:
    $assetsManager->getEmptyJsCollection();
    $assetsManager->getEmptyCssCollection();

    // Add inline scripts (css or js) to <head>.
    $assetsManager->addInline('test', '<link rel="stylesheet" href="../../_static/css/docs.css" type="text/css"/>');
    $assetsManager->removeInline('test');

You can get more details about the Assets from |phalcon_documentation|.

.. |phalcon_documentation| raw:: html

   <a href="http://docs.phalconphp.com/en/latest/reference/assets.html" target="_blank">Phalcon documentation</a>