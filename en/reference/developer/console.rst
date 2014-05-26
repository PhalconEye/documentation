Console
=======
Console allows to run some commands for remote purpose.

To run console manager, you will need to move into website root directory and execute:

.. code-block:: bash

    php public/index.php command param1 param2

Usage
-----
To use command simple type command and/or sub commands if required:

.. code-block:: bash

    php public/index.php database update

Some commands have aliases:

.. code-block:: bash

    php public/index.php db update

To show all available commands you can type:

.. code-block:: bash

    php public/index.php

    ## or ##

    php public/index.php help

Help can be used for command:

.. image:: /images/console_1.png
    :align: center

Or sub command:

.. image:: /images/console_2.png
    :align: center

Commands
--------
+--------------+-------------------------+---------------------------------------------------------------------+------------------------------------------------------+
| Name         | Sub command             | Parameters                                                          | Description                                          |
+==============+=========================+=====================================================================+======================================================+
| cache        | cleanup                 | ---                                                                 | Removes all cache stored by PhalconEye.              |
|              |                         |                                                                     | Also removes view cache, metadata, annotations,      |
|              |                         |                                                                     | assets, etc.                                         |
+--------------+-------------------------+---------------------------------------------------------------------+------------------------------------------------------+
| database, db | update                  | \- \- model=NULL (string|null) - Model class name, that must        | Updates all tables related to CMS and their relations|
|              |                         |   be updated. Example: \Core\Model\Some                             | according to models metadata (annotations) defined   |
|              |                         |                                                                     | in code.                                             |
|              |                         | \- \- cleanup - Remove tables, that isn't related (not mentioned)   |                                                      |
|              |                         |   to CMS                                                            |                                                      |
+--------------+-------------------------+---------------------------------------------------------------------+------------------------------------------------------+
| application, | sync                    | ---                                                                 | Synchronize application data with current copy       |
| app          |                         |                                                                     | of code. Imagine that you've created one module      |
|              |                         |                                                                     | (that is related to other module) and external       |
|              |                         |                                                                     | widget. And you have server for development and for  |
|              |                         |                                                                     | testing. Changes were made on development server and |
|              |                         |                                                                     | you need to move them into testing server.           |
|              |                         |                                                                     | You committed all changed data and fetched them on   |
|              |                         |                                                                     | on testing server (module and widget code and \*.json|
|              |                         |                                                                     | metadata). You runs this command and PhalconEye      |
|              |                         |                                                                     | synchronize all data in database: installs new,      |
|              |                         |                                                                     | removes old, etc... And adds new items to autoload   |
|              |                         |                                                                     | system. So, this tool is for synchronization between |
|              |                         |                                                                     | stage databases.                                     |
+--------------+-------------------------+---------------------------------------------------------------------+------------------------------------------------------+
| assets       | install                 | ---                                                                 | Installs all assets from modules and compiles theme  |
|              |                         |                                                                     | less files.                                          |
+--------------+-------------------------+---------------------------------------------------------------------+------------------------------------------------------+

Command Creation
----------------
Command can be created in module. Special directory "Command" must be placed in module root.

Command example:

.. code-block:: php

    <?php

    /**
     * Assets command.
     *
     * @category  PhalconEye
     * @package   Core\Commands
     * @author    Ivan Vorontsov <ivan.vorontsov@phalconeye.com>
     * @copyright 2013-2014 PhalconEye Team
     * @license   New BSD License
     * @link      http://phalconeye.com/
     *
     * @CommandName(['assets'])
     * @CommandDescription('Assets management.')
     */
    class Assets extends AbstractCommand implements CommandInterface
    {
        /**
         * Install assets from modules.
         *
         * @return void
         */
        public function installAction()
        {
            $assetsManager = new Manager($this->getDI(), false);
            $assetsManager->installAssets(PUBLIC_PATH . '/themes/' . Settings::getSetting('system_theme'));

            print ConsoleUtil::success('Assets successfully installed.') . PHP_EOL;
        }
    }

Each command must be extended from AbstractCommand and implements CommandInterface.
Commands metadata defined via class annotations:

.. code-block:: php

    <?php

    /**
     * @CommandName(['commandname', 'commandalias'])
     * @CommandDescription('Description of the command.')
     */
    class SomeCommand extends AbstractCommand {}

    /**
     * Command can gave initialization method, that will be performed before any action.
     *
     * @CommandName(['commandname', 'commandalias'])
     * @CommandDescription('Description of the command.')
     */
    class SomeCommand extends AbstractCommand {
        public function initialize() {}
    }

    /**
     * To define sub command - add subcommandAction method. It will be automatically added as sub command.
     *
     * @CommandName(['commandname', 'commandalias'])
     * @CommandDescription('Description of the command.')
     */
    class SomeCommand extends AbstractCommand {
        public function subcommandAction() {}
    }

    /**
     * Parameters of sub command automatically takes as parameters of it.
     * NOTE: action with parameters must be commented well, coz this will be a description of this commands!
     *
     * @CommandName(['commandname', 'commandalias'])
     * @CommandDescription('Description of the command.')
     */
    class SomeCommand extends AbstractCommand {
        /**
         * Test action with params.
         *
         * @param string|null $param1 Param1 - string. Example: "string".
         * @param bool        $param2 Param2 is flag.
         *
         * @return void
         */
        public function testAction($param1 = null, $param2 = false) {}

        // Help for this command will looks like this:
        //Help for "commandname test":
        //  Test action with params.
        //
        //Available parameters:
        //   --param1=NULL (string|null)           Param1 - string. Example: "string".
        //   --param2                              Param2 is flag.
    }

