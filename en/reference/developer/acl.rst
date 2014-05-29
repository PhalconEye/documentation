Access Control List
===================
ACL is based on `Phalcon ACL`_. Acl Roles are stored in database. Each user can have only one role.
In production mode Acl compiles from database and is cached by the system.

There is only one default Acl key: Core\\Api\\Acl::ACL_ADMIN_AREA ('AdminArea'). This key is used for admin panel access.
By default there are three roles: Admin, User and Guest. All not authenticated requests assigned to Guest Role.
Logged-in sessions are assigned to User. Admin is the most privileged Role.

ACL Usage
---------
Acl class is part of Core module API and can be accessed via api container (core container) from DI.

In controller:

.. code-block:: php

    <?php

    // Check if current user has access to perform given action on the resource.
    $this->core->acl()->isAllowed($viewer->getRole()->name, $resource, $action) == Acl::ALLOW;

    // Get allowed value on given resource for user.
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
Let's take the Blog system as an example. We can allow or disallow access for some roles to perform actions such as:
"create", "edit" and "delete". Also we have two values:

    * "blog_footer" - Displays some HMTL content in footer on each blog (eg. for user: "<b>Hello world</b>" and for guest: "Bye").
    * "blog_count" - Number of blogs per page on browse page.

We can also define required actions and their values in blog model via annotation @Acl:

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
Note: In development mode PhalconEye will automatically pick up all changes made to models.

.. _`Access Rights`: ../user/access.html

.. _`Phalcon ACL`: http://docs.phalconphp.com/en/latest/reference/acl.html