App directory
=============

Configuration
-------------
This directory contains different configuration stages. More info you can find in other :doc:`section <../configuration>` of documentation.

Engine
------
Engine directory is heart of CMS. Here under the hood main horsepower =).

Libraries
---------
Libraries that can be installed via packages system. Read more information about :doc:`packages <../packages>` in other section.

Modules
-------
:doc:`Modules <../packages/modules>` are also part of packages. But here we can find default two modules: Core and User.

| Core module contains code for general classes of CMS. Also it implements admin panel logic.
| User module pointed on work with users.

Plugins
-------
One more type of package. :doc:`Plugins <../packages/plugins>` exist for defining additional logic by system events (events handlers).

Var
----
Var directory is for main garbage =). Contains: logs, temp files (that currently processing), system data (metadata about packages), cache.

Widgets
-------
And again - package. :doc:`Widget <../packages/widgets>` is main composition object of dynamic pages.
Widgets used by end user for structuring his dynamic page. For example: html widget, when end user want to add some html to his page.