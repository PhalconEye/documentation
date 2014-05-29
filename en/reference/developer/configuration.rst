Configuration
=============

Stages
------
Stages allow you to set different configuration per virtual host, server, etc. By default, PhalconEye comes with two stages: "development" and "production".
CMS is bundled with "development" stage, this is defined in '/public/.htaccess' file:

.. code-block:: apache

    SetEnv PHALCONEYE_STAGE development

If a stage isn't defined "production" will be used.
You are allowed to add as many stages as you want, just create new directory inside 'config' folder and set default configuration.

Config files
------------
Configuration contains two default files, which are necessary for the system:

1. application.php - contains main settings for application (cache, view, logging, etc). You can find most of these settings in |phalcon_documentation|.

.. code-block:: php

    <?php
    return array(
        'debug' => true,                        // Use debug mode?
        'profiler' => true,                     // Show profiler for admins?
        'baseUrl' => '/',                       // Base site url.
        'cache' =>
            array(
                'lifetime' => '86400',
                'prefix' => 'pe_',
                'adapter' => 'File',
                'cacheDir' => ROOT_PATH . '/app/var/cache/data/',
            ),
        'logger' =>
            array(
                'enabled' => true,
                'path' => ROOT_PATH . '/app/var/logs/',
                'format' => '[%date%][%type%] %message%',
            ),
        'view' =>
            array(
                'compiledPath' => ROOT_PATH . '/app/var/cache/view/',
                'compiledExtension' => '.php',
                'compiledSeparator' => '_',
                'compileAlways' => true,
            ),
        'session' =>
            array(
                'adapter' => 'Files',
                'uniqueId' => 'PhalconEye_',
            ),
        'assets' =>
            array(
                'local' => 'assets/',           // Local assets location.
                'remote' => false,              // This can be used for your CDN.
            ),
        'metadata' =>
            array(
                'adapter' => 'Files',
                'metaDataDir' => ROOT_PATH . '/app/var/cache/metadata/',
            ),
        'annotations' =>
            array(
                'adapter' => 'Files',
                'annotationsDir' => ROOT_PATH . '/app/var/cache/annotations/',
            )
    );

2. database.php - contains info about database.

.. code-block:: php

    <?php
    return array(
        'adapter' => 'Mysql',
        'host' => 'localhost',
        'port' => '3306',
        'username' => 'root',
        'password' => NULL,
        'dbname' => 'phalconeye',
    );

Behaviour
---------
All \*.php files under stage directories are merged into one structure. For example we can have the following files:

.. code-block:: text

    .
    └─── development
        ├── application.php
        ├── yourconfig.php
        ├── yourconfig2.php
        └── database.php

It means that in "development" stage we would be able to get the values as follows:

.. code-block:: php

    <?php

    $config = $this->getDI()->getConfig();

    // Get debug mode.
    $isDebug = $config->application->debug;

    // Get database adapter.
    $adapter = $config->database->adapter;

    // Get custom config value.
    $someValue = $config->yourconfig->someValue;

If current stage isn't "development" merged configuration will be cached in /app/var/cache/data/config.php file.

.. _Phalcon documentation: http://docs.phalconphp.com/
.. |phalcon_documentation| raw:: html

   <a href="http://docs.phalconphp.com/" target="_blank">Phalcon documentation</a>