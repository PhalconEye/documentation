Access Rights
=============

Access Rights allows to control access restrictions for specific areas of the CMS.
These Resources and their access policies may be defined by modules.

By default, the Core module comes with two Resources:

* "AdminArea"
* "\Core\Model\Page"

.. image:: /images/access_1.png
    :align: center

\Core\Model\Page Resource has two configurable actions:

.. image:: /images/access_2.png
    :align: center

* "Show_views" - displays visits counter of on current page.
* "Page_footer" - stores additional HTML code.

These actions can be assigned individually to each Role_, ("Admin" Role in this case) visible in the top right corner.

To make it clear look at another example:

.. image:: /images/access_3.png
    :align: center

Here, defined backend access rights for role "Admin" - it will let Admin users to access the Administration area.

Texts like "ACTION_ADMINAREA_ACCESS_DESCRIPTION" are translation placeholders and can be changed in language_ management system.

.. _language: languages.html
.. _Role: roles.html
