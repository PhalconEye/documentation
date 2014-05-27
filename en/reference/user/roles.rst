Role management
===============

PhalconEye enables Administrators to define privileged groups of users.

.. image:: /images/roles_1.png
    :align: center

To add a new Role go to "Create new role" from top navigation bar and fill-in the form:

.. image:: /images/roles_2.png
    :align: center

Fields description:

    **Name** - name of the new Role

    **Description** - short description of the Role

    **Is Default** - whether the Role should be assigned to all new users

By default PhalconEye comes with 3 system Roles:

* **Admin** - administrators who can access backend of the CMS
* **User** - this is the default Role for users who register on your website
* **Guest** - all visitors

These system Roles can not be deleted as opposed to new Roles created by Administrators, which can be removed via grid_ system.

.. _grid: grid.html
