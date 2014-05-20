Views
=====
* `Views in Phalcon`_ - overall information about views in framework Phalcon.
* `Volt template engine`_ - about view template engine.

Volt engine is used as main rendering processor. Views can be found in modules and widgets.

Widget views
------------
Widget can have one or several views, depends on it's controller actions. By default: index.volt. This view will be used for indexAction
of widget controller.

Module views
------------
Module views located under directory "View". Dispatcher resolves view according to controller and it's action name.
For example, if you have "SomeController" and "newAction" method view for this action must be placed under /View/Some/new.volt (sensitive register).

Core module has default layouts for admin and main page layout, to use them, you must add "extends" modifier:

    **Note:** Path to layout view must be relative.

.. code-block:: html+jinja

    {% extends "../../Core/View/layouts/main.volt" %} {# Main layout, used for all frontend views. #}

    {% extends "../../Core/View/layouts/admin.volt" %} {# Admin layout, used in admin views. #}

    {% extends "../../Core/View/layouts/widget.volt" %} {# Widget layout, used in widgets views. #}

Helpers
-------
You can read more about them in other part about helpers_.

You can use helpers inside your views, this allows to move server logic to php, outside from view part.

.. code-block:: html+jinja

    {{ helper('setting', 'core').get('system_title', '') }} {# Get setting 'system_title', with default value ''. #}

First parameter is helper class name (in that case, this will be Setting.php. Second parameter is namespace of this helper,
by default this is 'engine', in that example - 'core'. It means, that this class is accessible at Core\Helper\Setting.
After that call helper system returns your an object of Core\Helper\Setting, this object created only once and by other calls it
taken from cache (by singletone logic). Cache in that case is DI, so you also can check if helper is loaded by accessing it in DI:

.. code-block:: php

    <?php

    $di->has('Core\Helper\Setting');

Extension
---------
View has some additional methods and filters.

.. code-block:: html+jinja

    {# classof (get_class in php): #}
    {% if classof(element) is 'FieldSet' %}
    ...
    {% endif %}

    {# instanceof in php: #}
    {% if instanceof(element, 'Engine\Form\FieldSet') %}
    ...
    {% endif %}

    {# resolveView, allows to find relative path to view. First parameter is view name, second - module name: #}
    {{ partial(resolveView('partials/paginator', 'core')) }}

    {# i18n filter, for translations: #}
    {{ "Some text" | i18n }}

.. _helpers: ../helpers.html

.. _`Views in Phalcon`: http://docs.phalconphp.com/en/latest/reference/views.html
.. _`Volt template engine`: http://docs.phalconphp.com/en/latest/reference/volt.html