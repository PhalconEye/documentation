Widgets
=======
Widgets are main components of your content! Widget is component that has it's own controller and view. It can be placed on page and rendered by request.

.. code-block:: text

    ./Widget/
    └── HtmlBlock
        ├── Controller.php
        └── index.volt

Widgets can be part of some module or as external package.
By default "index" action is used, but you can render widget with another action using widget wrapper - Engine\Widget\Element->render("update").

Controller
----------
Let's look on Controller example:

.. code-block:: php

    <?php

    class Controller extends Engine\Widget\Controller
    {
        /**
         * Index action.
         * This action is rendered by default.
         *
         * @return void
         */
        public function indexAction()
        {
            // Get parameter provided by PhalconEye system.
            // This parameters handled by admin panel, when enduser can place his widget and setup some params.
            $param = $this->getParam('count');

            // Get all params for this widget.
            $param = $this->getAllParams();

            // Engine\Widget\Controller is extended from Phalcon controller and it has DI services.
            // So you can use anything from DI.
            // As for example - get param from HTTP request.
            $queryParam = $this->request->get("param");

            // Access to DI.
            $di = $this->getDI();

            // Set View params.
            $this->view->someParam = 1;

            // Set widget title, it's automatically takes from form params (added by enduser), but you can override it.
            $this->view->title = "Some Title";

            // Set flag, that widget has no content and it's wrapper must not be rendered.
            return $this->setNoRender();
        }

        /**
         * This action is used, when user requests widgets options at page layout management.
         *
         * @return CoreForm
         */
        public function adminAction()
        {
            return new YourWidgetFormClass();
        }

        /**
         * Cache this widget?
         * This method for wrapper, that will check, if you widget content must be cached.
         *
         * @return bool
         */
        public function isCached()
        {
            // If this method exists in widget controller
            // and returns "true" - rendered content of widget's view will be cached and used at next time.
            return true;
        }

        /**
         * Get widget cache key.
         *
         * @return string|null
         */
        public function getCacheKey()
        {
            // You can use this method to specify your widget cache.
            // By default system generates unique cache key automatically.
            // Note that this method will not be used if "isCached" method doesn't returns "true".
            return "some_you_unique_key";
        }

        /**
         * Get widget cache lifetime.
         *
         * @return int
         */
        public function getCacheLifeTime()
        {
            // Specify cache life time for your widget's cache.
            // 300 - is by default.
            return 300;
        }
    }

View
----
Let's look on index.volt example:

.. code-block:: html

    {% extends "../../Core/View/layouts/widget.volt" %}

    {% block content %}
    {{ html }}
    {% endblock %}

Block "content" is main widget block. Here you can use usual volt template features.

    **Note:** You can use Core layout "../../Core/View/layouts/widget.volt" or create your own. But if you are using Core - specify full path to it (relative).

Admin Form
----------
Widget params can be configured at widget options form at admin panel. Go to admin panel -> Pages -> Push on "Manage" link for some page -> find widget in layout (or place a new one) and push "Edit" link.

    **Note:** Widget can have default params:

    "title" - "Title" field at admin form.

    "count" - "Is paginated" field at admin form.

    "roles" - "Is ACL controller" field at admin form.

How default widget form looks (when all options allowed, title - is always present, by default):

.. image:: /images/packages_8.png
    :align: center

Configure your own admin form you can in 2 ways:

1) At widget creation (or in database, field - "admin_form") set to "action". This will triggers "actionIndex" in widget controller.
This action must return CoreForm instance, that will be rendered at admin panel (As example, look at HtmlBlock widget code).

2) At widget creation (or in database, field - "admin_form") set to "Some\Namespace\FormClass". This will create instance of "Some\Namespace\FormClass"
when the user will request widget admin form.