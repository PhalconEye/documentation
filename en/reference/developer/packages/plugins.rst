Plugins
=======
Plugins is just like an event handlers. When you need some additional hooks - you can create plugins.

Plugins can be as part of module and as external package.

Let's look on example:

.. code-block:: php

    <?php

    class DispatchErrorHandler
    {
        /**
         * Before exception is happening.
         *
         * @param Event            $event      Event object.
         * @param Dispatcher       $dispatcher Dispatcher object.
         * @param PhalconException $exception  Exception object.
         *
         * @throws \Phalcon\Exception
         * @return bool
         */
        public function beforeException($event, $dispatcher, $exception)
        {
            // Handle exceptions.
            // Some other code...
            return true;
        }
    }

This example from core (Engine\Plugin\DispatchErrorHandler) and attached to system as:

.. code-block:: php

    <?php

    $eventsManager->attach("dispatch:beforeException", new DispatchErrorHandler());

That means, that you can attach your plugins manually.

Events Editor
-------------
If you want to automate you plugin (and make it editable), you can use Package Manager. It has events editor.

.. image:: /images/packages_7.png
    :align: center

Events manager allowed for modules and plugins package types.
In left field you enter event name, in right field - class with namespace that must handle this event. You can use both formats of event naming (dispatch or dispatch:eventName). Read more about events system at `Phalcon documentation`_.

.. _`Phalcon documentation`: http://docs.phalconphp.com/en/latest/reference/events.html
