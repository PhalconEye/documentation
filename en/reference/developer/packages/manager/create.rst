Create new package
==================
If you need to create new package, you can use PhalconEye tool - Package manager. It will allow you to create structured package.

Go to Admin panel -> Packages (left sidebar) -> Create new package (top menu).
Fill form with your data:

.. image:: /images/packages_2.png
   :align: center

Form data:

* **Name**                - Package unique name. Used to form package directory and other identification stuff.
* **Package type**        - Package type: module, widget, theme, plugin, library.
* **Title**               - Package title, that will be represent your package.
* **Description**         - Package description, short description of your package.
* **Version**             - What version? Mask: x.x.x or x.x.x.x.
* **Author**              - Who is author?
* **Website**             - Your website.
* **Header comments**     - This comments will be placed in all files, that will be generated, you can use it for your license.


Create "widget" package
-----------------------
If you will select package type "Widget" you will see that form has additional fields:

.. image:: /images/packages_3.png
   :align: center

Additional data:

* **Is related to module?**     - Here you can select related of your widget. Selectbox listed all current installed modules and has option "NO".
                                * If you will select option "NO" - you widget will be placed at /app/widget/<YOUWIDGETID> and marked as non-related.
                                * If you choose some module - you widget will be placed at /app/modules/<MODULE THAT YOU SELECTED>/Widget/<YOUWIDGETID>.

* **Is paginated?**             - Mark widget as paginated. If you will check this - widget admin options form will have text box, where user will be able to enter amount of data that must be showed in frontend. At widget controller you will be able to check if this option and get this amount for your paginator.

* **Is ACL controlled?**        - Same as "Is paginated" - adds multiselect box that will allow to select when this widget bust be shown (which role can do this). Unlike "Is paginated" - ACL is controlled by system, and will not need to implement is in widget controller.

* **Admin form**                - Here we have three options:
                                * No (will be used default admin form with widget block title, paginator option and ACL if they enabled),
                                * "Action" (each time when user will request widget admin form - adminAction will be used from widget controller, this action must return Form object).
                                * "Form class" (type form class, that must be processed each time when user requests widget admin options form, e.g.: "Some\Namespace\FormClass".

* **Enabled?**                  - This widget is enabled, and enduser can use it?