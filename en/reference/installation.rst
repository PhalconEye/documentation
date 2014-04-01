Installation
============

1. Install Phalcon (1.3.1 version is required, how to do this: http://docs.phalconphp.com/en/latest/reference/install.html).
2. If you cloned it PhalconEye from github you can run ant task (ant dist) and get package as zip.
3. Unzip (or copy) CMS code to your webserver.
4. 'public' directory must be set as server's web root.
5. Go to http://youhost.com/ and you will see the installation process.
   If you installing CMS not in webroot (e.g.: http://youhost.com/phalconeye/)
   you must edit configuration in /app/config/development/application.php and
   set value of 'baseUrl' to your subdirectory path (as for e.g.: '/phalconeye/'). Visit site.
6. Follow the installation process.