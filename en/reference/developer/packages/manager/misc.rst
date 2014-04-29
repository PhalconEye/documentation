Edit, disable, uninstall package
================================
Assume, that you have created new package and now you need to change some information (for e.g. version) or you need to create \*.zip package from it.

Edit
----
You can edit information about your package. Edit form is limited, but you can change "meta" info about it.

.. image:: /images/packages_5.png
   :align: center

Disable
-------
You can disable package, it is possible from list. Go to Package manager -> <Package type> -> Find it in list and click "Disable"/"Enable" button.
There are some limits for this functionality:

* Package which has dependencies can not be disabled or uninstalled.
* Package that is disabled - will not be loaded to PHP autoloader, this means that you will lose it's features.


Uninstall
---------
To uninstall your package, please use Package manager or you risking to broke you system.

Go to Package manager -> <Package type> -> Find it in list and click "Uninstall" button. If package has dependencies system will not allow
you to uninstall it.
