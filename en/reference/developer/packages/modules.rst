Module Package
==============
Modules - is main package type. It can be represented as standalone subsystem and can hold widgets, plugins, libraries, but not themes.

.. code-block:: text

    .
    ├── package
    │   ├── Api
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

Let's look an all aspects of module structure:

Module Api
----------
This API just like a DI wrapper that allows to create API classes at module level. You can access to known API using module key in DI.

For example: Core module has class Core\\Api\\Acl that can be accessed in such way:

.. code-block:: php

    <?php

    // Note: getObject is a method of class Core\Api\Acl

    // In controller (or in any Phalcon\DI\Injectable):
    $this->core->acl()->getObject($id);

    // In any other place:
    $this->getDI()->get("core")->acl()->getObject($id);

    // Structure:
    $this->getDI()->get("MODULE_NAME")->API_CLASS()->API_CLASS_METHOD

By the way... all object's that were accessed stay at DI with key of it's namespace...

.. code-block:: php

    <?php

    $this->core->acl()->getObject($id);

    // Note that "Core\Api\Acl" key will be in DI only if you call it special API wrapper, by default it's not initialized.
    // So this like a cache usage without wrapper, in such way you can trigger when your API was used.
    $this->getDI()->get("Core\Api\Acl")->getObject($id);


Assets
------
Assets directory goal - all module must have it's own frontend styles and visualization,
so Assets must have (required) 3 directories: css, img, js. This directories is using as assets source for overall assets compilation.

.. code-block:: text

   /app/modules/Core/Assets
    ├── css
    │   ├── admin
    │   ├── install.less
    │   └── profiler.less
    ├── img
    │   ├── admin
    │   ├── grid
    │   ├── loader
    │   ├── misc
    │   ├── pe_logo.png
    │   ├── pe_logo_white.png
    │   └── profiler
    ├── js
    │   ├── admin
    │   ├── core.js
    │   ├── form
    │   ├── form.js
    │   ├── i18n.js
    │   ├── pretty-exceptions
    │   ├── profiler.js
    │   └── widgets
    └── sql
        └── installation.sql


If you will look at public_ directory you will find "assets" directory there. This directory is accessible through web server.
It contains all assets collected from installed modules, for example, if we have 3 modules core, user and blog we will have such structure:

.. code-block:: text

    public
    └── css
       ├── core
       │   └── somestyle.css           // Originally this file is located at /app/modules/Core/Assets/css/somestyle.css
       ├── user
       │   ├── somedir
       │   │   └── someotherstyle.css  // This file is located at /app/modules/User/Assets/css/somedir/someotherstyle.css
       │   └── somestyle.css
       ├── blog
       │   └── somestyle.css
       ├── constants.css               // This files located at /public/themes/<current theme>/*.less(*.css)
       └── theme.css

On this example (css only included) we can see structure after assets installation (collection). This files copied from modules
Assets directory with directory tree structure, this work only for directories located in Assets and named as "css", "img", "js".
Other directories doesn't affected by assets system, so if you will have directories like "sql" or "data" in Assets - they will not be copied
to /public/assets directory.

Assets can be installed from console, using command: "php public/index.php assets install". You can read about `commands manager`_ and console usage in this documentation.
Also assets can be installed via "debug" switcher, when you enabling or disabling "debug" flag - system cleans cache and installs new assets.

    **Note:** "css" directory can contains \*.less files and \*.css files. \*.css files will be copied to public dir, but \*.less will be compiled to \*.css using constants.less from
    current theme. In that case constants.less can be used to archive main style of current theme (main colors, block sizes, etc).

Command
-------
This directory contains commands classes, that can be used in console. You can read more about commands in `commands manager`_ section.

Controller
----------
Controller directory contains all module controllers, request handlers. You can read how to use them at `Phalcon documentation`_.

Form
----
Contains all forms classes, usually it can have such structure:

.. code-block:: text

    /app/modules/User/Form/
    ├── Admin
    │   ├── Create.php
    │   ├── Edit.php
    │   ├── RoleCreate.php
    │   └── RoleEdit.php
    └── Auth
        ├── Login.php
        └── Register.php

How to create and use forms you can read in `special section`_ of this documentation.

Helper
------
Usually helpers oriented as View helpers, but you can use them everywhere in your code (where DI is available). Read about more helpers_.

Model
-----
Here is all module models (database entities). Read about models_.

Plugin
------
Plugins used as event handlers. Each plugin can have attached event handlers to class. Read about plugins_.

View
----
This directory contains views. There are directories with controller name inside which you can find views with extension (\*.volt).
Here some useful links about views:

* `Views in PhalconEye`_ - about internal system of views.
* `Views in Phalcon`_ - overall information about views in framework Phalcon.
* `Volt template engine`_ - about view template engine.

Widget
------
If you will look at Core module, you will find 3 widget there:

.. code-block:: text

    /app/modules/Core/Widget/
    ├── Header
    │   ├── Controller.php
    │   └── index.volt
    ├── HtmlBlock
    │   ├── Controller.php
    │   └── index.volt
    └── Menu
        ├── Controller.php
        └── index.volt

Each directory inside "Widget" directory - is independent widget. Widget has it's own controller and one or several views
(depends on actions, that you need inside controller). Read more about widgets_.

Installer
---------
Installer is a script that allows to do some actions per installation/update or removal.
Let's look on example (Core installer):

.. code-block:: php

    <?php

    use Engine\Installer as EngineInstaller;
    use Phalcon\Acl as PhalconAcl;

    class Installer extends EngineInstaller
    {
        const
            /**
             * Current package version.
             */
            CURRENT_VERSION = '0.4.0';

        /**
         * Used to install specific database entities or other specific action.
         *
         * @return void
         */
        public function install()
        {
            $this->runSqlFile(__DIR__ . '/Assets/sql/installation.sql');
        }

        /**
         * Used before package will be removed from the system.
         *
         * @return void
         */
        public function remove()
        {

        }

        /**
         * Used to apply some updates.
         * Return 'string' (new version) if migration is not finished, 'null' if all updates were applied.
         *
         * @param string $currentVersion Current module version.
         *
         * @return string|null
         */
        public function update($currentVersion)
        {
            return null;
        }
    }

As you can see, installer has 3 mandatory methods: install, remove, update.

* **install** method executes after package was unpacked and moved to it's location (modules directory). Executes only after autload setup.
* **remove** method executes before module removal from package manager.
* **update** method executes when user tries to install module of new version. In that case update will be executed several times until update process will reach current version.

For example, if current installed version is 1.0.0 and new package is 1.2.1. At 1.1.0 and 1.2.0 were database
changes that you want to trigger correctly. Method "update" can look like this:

.. code-block:: php

    <?php
    class Installer extends EngineInstaller
    {
        const
            /**
             * Current package version.
             */
            CURRENT_VERSION = '1.2.1';


        public function update($currentVersion)
        {
            switch($currentVersion){
                case "1.1.0"
                    // Apply database changes from 1.0.0 to 1.1.0.
                    ... CODE HERE...
                    return "1.2.0";
                break;
                case "1.2.0"
                    // Apply database changes from 1.2.0 to 1.2.1.
                    ... CODE HERE...
                    return CURRENT_VERSION;
                break;
            }

            return null;
        }
    }

Bootstrap
---------
Bootstrap initialize module systems and can adds some services to DI for other modules.

    **Note:** Please, don't use huge initialization at bootstrap, coz if you will have more then 10 modules with huge initializations at bootstrap
    your system will be very slow!

.. code-block:: php

    <?php
    namespace Core;

    use Core\Model\Language;
    use Core\Model\LanguageTranslation;
    use Core\Model\Settings;
    use Core\Model\Widget;
    use Engine\Bootstrap as EngineBootstrap;
    use Engine\Cache\System;
    use Engine\Config;
    use Engine\Translation\Db as TranslationDb;
    use Phalcon\DI;
    use Phalcon\DiInterface;
    use Phalcon\Events\Manager;
    use Phalcon\Mvc\View\Engine\Volt;
    use Phalcon\Mvc\View;
    use Phalcon\Translate\Adapter\NativeArray as TranslateArray;
    use User\Model\User;

    /**
     * Core Bootstrap.
     *
     * @category  PhalconEye
     * @package   Core
     * @author    Ivan Vorontsov <ivan.vorontsov@phalconeye.com>
     * @copyright 2013-2014 PhalconEye Team
     * @license   New BSD License
     * @link      http://phalconeye.com/
     */
    class Bootstrap extends EngineBootstrap
    {
        /**
         * Current module name.
         *
         * @var string
         */
        protected $_moduleName = "Core";

        /**
         * Bootstrap construction.
         *
         * @param DiInterface $di Dependency injection.
         * @param Manager     $em Events manager object.
         */
        public function __construct($di, $em)
        {
            parent::__construct($di, $em);

            /**
             * Attach this bootstrap for all application initialization events.
             */
            $em->attach('init', $this);
        }

        /**
         * Init some subsystems after engine initialization.
         */
        public function afterEngine()
        {
            $di = $this->getDI();
            $config = $this->getConfig();

            $this->_initI18n($di, $config);
            if (!$config->installed) {
                return;
            }

            // Remove profiler for non-user.
            if (!User::getViewer()->id) {
                $di->remove('profiler');
            }

            // Init widgets system.
            $this->_initWidgets($di);

            /**
             * Listening to events in the dispatcher using the Acl.
             */
            if ($config->installed) {
                $this->getEventsManager()->attach('dispatch', $di->get('core')->acl());
            }

            // Install assets if required.
            if ($config->application->debug) {
                $di->get('assets')->installAssets(PUBLIC_PATH . '/themes/' . Settings::getSetting('system_theme'));
            }
        }

        /**
         * Init locale.
         *
         * @param DI     $di     Dependency injection.
         * @param Config $config Dependency injection.
         *
         * @return void
         */
        protected function _initI18n(DI $di, Config $config)
        {
            $translate = ...
            // SOME CODE HERE

            $di->set('i18n', $translate);
        }

        /**
         * Prepare widgets metadata for Engine.
         *
         * @param DI $di Dependency injection.
         *
         * @return void
         */
        protected function _initWidgets(DI $di)
        {
            if ($di->get('app')->isConsole()) {
                return;
            }

            $widgets = ...
            // SOME CODE HERE

            $di->get('widgets')->addWidgets($widgets);
        }
    }

As you can see, bootstrap also can be attached to system events, to handle additional logic.

.. _public: ../../structure/public.html
.. _`commands manager`: ../console.html
.. _`special section`: ../forms.html
.. _helpers: ../helpers.html
.. _models: ../models.html
.. _plugins: ../packages/plugins.html
.. _`Views in PhalconEye`: ../views.html
.. _widgets: widgets.html

.. _`Phalcon documentation`: http://docs.phalconphp.com/en/latest/reference/controllers.html
.. _`Views in Phalcon`: http://docs.phalconphp.com/en/latest/reference/views.html
.. _`Volt template engine`: http://docs.phalconphp.com/en/latest/reference/volt.html