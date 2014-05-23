Access Control List
===================
ACL is based on `Phalcon ACL`_. Acl roles stored in database. User can have one role.
In production mode Acl compiles from database and cached by system.

There is only one default acl key: Core\\Api\\Acl::ACL_ADMIN_AREA ('AdminArea'). This key is used for admin panel access.
By default there are three roles: Admin, User, Guest. All not authenticated requests are guests. Logged in is user.
And admin, that has more access than user.

ACL Usage
---------
Acl class is implemented as Core module API, so it can be accessed via api container (core container) inside DI.

In controller:

.. code-block:: php

    <?php

    // Check that current user have access to some action on resource.
    $this->core->acl()->isAllowed($viewer->getRole()->name, $resource, $action) == Acl::ALLOW;

    // Get allowed value to user on resource.
    $this->getDI()->get('core')->acl()->getAllowedValue($resource, $viewer->getRole(), $valueName);

In view:

.. code-block:: html+jinja

    {# Check if user is allowed to view, and show something. #}
    {% if helper('acl').isAllowed('\Core\Model\Page', 'show_views') %}
        <div class="page_views">{{ 'View count:'|i18n }}{{ page.view_count }}</div>
    {% endif %}

    {# Check if user is allowed to view, and show something. #}
    {{ helper('acl').getAllowed('\Core\Model\Page', 'page_footer') }}


Model ACL
---------
For example we have blog system. And we want to allow or disallow access for some roles to actions "create", "edit" and "delete". Also we have
two values:

    * "blog_footer" - Show some html to users as footer to each blog (for example, for user: "<b>Hello world</b>" and for guest: "Bye").
    * "blog_count" - Count of blogs per page on browse page.

We need to define required actions and values in blog model via annotation @Acl:

.. code-block:: php

    <?php

    /**
     * Blog model.
     *
     * @category  PhalconEye
     * @package   Blog\Model
     * @author    Ivan Vorontsov <ivan.vorontsov@phalconeye.com>
     * @copyright 2013-2014 PhalconEye Team
     * @license   New BSD License
     * @link      http://phalconeye.com/
     *
     * @Source("blogs")
     * @Acl(actions={"create", "edit", "delete"}, options={"blog_footer", "blog_count"})
     */
    class Blog extends AbstractModel
    {

    }

After defining required actions and values you can set their values in admin panel via `Access Rights`_ system.
All changes made to models triggers automatically in development mode.

.. _`Access Rights`: ../user/access.html

.. _`Phalcon ACL`: http://docs.phalconphp.com/en/latest/reference/acl.html