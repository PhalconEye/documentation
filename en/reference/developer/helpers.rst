Helpers
=======
Mainly helpers existing for view extension. When in view must be performed some huge logic - this part of work can be moved to helper.

Helpers can be accessible in view in such way:

.. code-block:: html+jinja

    {{ helper('setting', 'core').get('system_title', '') }} {# Get setting 'system_title', with default value ''. #}

First parameter is helper class name (in that case, this will be Setting.php. Second parameter is namespace of this helper,
by default this is 'engine', in that example - 'core'. It means, that this class is accessible at Core\Helper\Setting.
After that call helper system returns your an object of Core\Helper\Setting, this object created only once and by other calls it
taken from cache (by singleton logic). Cache in that case is DI, so you also can check if helper is loaded by accessing it in DI:

.. code-block:: php

    <?php

    $di->has('Core\Helper\Setting');

Helper class can be used in other places:

.. code-block:: php

    <?php

    // Using static method.
    $settingsHelper = \Engine\Helper::getInstance('setting', 'core');
    $systemTitle = $settingsHelper->get('system_title', '');

    // Or directly from required class.
    $settingsHelper = \Core\Helper\Setting::getInstance($this->getDI());
    $systemTitle = $settingsHelper->get('system_title', '');

Helper creation
---------------
To create helper you need extend it from Engine\\Helper and write your methods:

.. code-block:: php

    <?php

    class NewHelper extends \Engine\Helper
    {
        public function someMethod1(){}

        public function someMethod2(){}
    }

Existing helpers
----------------
Here is list of available helpers:

+--------------+---------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+
| Name         | Namespace                                   | Methods                                                                                                                    |
+==============+=============================================+============================================================================================================================+
| Assets       | Engine\\Helper\\Assets                      | * addJs($file, $collection = 'js') - Adds js file to assets collection.                                                    |
|              |                                             | * addCss($file, $collection = 'css') - Adds css file to assets collection.                                                 |
+--------------+---------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+
| Formatter    | Engine\\Helper\\Formatter                   | * formatNumber($number, $style = \\NumberFormatter::DECIMAL) - Format number according to current locale.                  |
|              |                                             | * formatCurrency($number) - Format currency as \\NumberFormatter::CURRENCY (according to current locale).                  |
+--------------+---------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+
| Url          | Engine\\Helper\\Url                         | * currentUrl() - Get current URL from request.                                                                             |
|              |                                             | * paginatorUrl($pageNumber = null) - Generate url for paginator.                                                           |
+--------------+---------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+
| I18n         | Core\\Helper\\I18n                          | * add($translations, $params = []) - Add translation to temporary storage, this is for js translations.                    |
|              |                                             | * js($translations, $params = []) - Render js translations, $translations overrides current temporary storage.             |
|              |                                             | * clear() - clear temporary storage.                                                                                       |
|              |                                             | * render($translations = null) - Render translations, without params concatenation.                                        |
|              |                                             |                                                                                                                            |
|              |                                             | All data after rendering placed in js variable "translatorData".                                                           |
|              |                                             | Usage in php:                                                                                                              |
|              |                                             |                                                                                                                            |
|              |                                             | .. code-block:: php                                                                                                        |
|              |                                             |                                                                                                                            |
|              |                                             |      <?php                                                                                                                 |
|              |                                             |                                                                                                                            |
|              |                                             |      I18n::getInstance($this->getDI())                                                                                     |
|              |                                             |                ->add('Are you really want to delete this item?')                                                           |
|              |                                             |                ->add('Hello %item%', ['item' => 'World'])                                                                  |
|              |                                             |                ->add('Close this window?');                                                                                |
|              |                                             |                                                                                                                            |
|              |                                             |                                                                                                                            |
|              |                                             | Usage in volt:                                                                                                             |
|              |                                             |                                                                                                                            |
|              |                                             | .. code-block:: html+jinja                                                                                                 |
|              |                                             |                                                                                                                            |
|              |                                             |      {{ helper('i18n', 'core').add('Hello %item%', ['item' => 'World']) }}                                                 |
|              |                                             |      {{ helper('i18n', 'core').render() }}                                                                                 |
+--------------+---------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+
| Renderer     | Core\\Helper\\Renderer                      | * renderContent($pageType, $layout = null) - Render page widgets, if layout isn't defined - plain rendering will be used.  |
|              |                                             | * renderWidget($id, $params = []) - Render some widget with params.                                                        |
|              |                                             | * renderWidgetId($id, $params = []) - Render widget by ID from database.                                                   |
|              |                                             | * widgetIsAllowed($params) - Check that widget is allowed by it's parameters.                                              |
+--------------+---------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+
| Acl          | Core\\Helper\\Acl                           | * isAllowed($resource, $action) - Check that current used is allowed to resource by action.                                |
|              |                                             | * getAllowed($resource, $valueName) - Get allowed value for current user according to resource and action.                 |
+--------------+---------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+
| Setting      | Core\\Helper\\Setting                       | * get($name, $default = null) - Get setting from database.                                                                 |
+--------------+---------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+
| User         | User\\Helper\\User                          | * current() - Get current user.                                                                                            |
|              |                                             | * get($id) - Get user by id.                                                                                               |
|              |                                             | * isUser() - Check that current user is logged in.                                                                         |
+--------------+---------------------------------------------+----------------------------------------------------------------------------------------------------------------------------+



