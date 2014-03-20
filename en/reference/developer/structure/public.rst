Public directory
================

As normal practice public directory must be defined as WWW_ROOT.
Public directory allows to store static files like assets and user files.
Here we can find some directories by default:

    * assets
    * external
    * files
    * themes

Assets
------
Assets files could be any files required by your application (css, js, images, etc).
This directory is controlled by CMS. Don't try to copy there any of your files.
Assets files installing to this directory directly from modules (each module has it's own directory with Assets files).
Files under modules can't be accessed via http, so, they are installed here for farther usage.

External
--------
This directory for external libs and programs. Here we can find jQuery files, Bootstrap css and other.

Files
-----
This directory used for different public files. Also it's used by Ajaxplorer tool.

Themes
------
CMS themes files. Here can be directories with different files formats (less, css, images, etc).
More detail information you can find in other section, which focused on :doc:`themes <../packages/themes>`.