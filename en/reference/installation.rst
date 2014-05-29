Installation
============

1. Get Phalcon Framework up and running (1.3.1 version is required). See http://docs.phalconphp.com/en/latest/reference/install.html
2. If you cloned PhalconEye from GitHub, you must run ant task (ant assets) which will generate static JavaScript and css files.
3. Deploy PhalconEye's code onto your webserver (you can run ant dist to generate a package).
4. 'public' directory must be set as server's web root. VirtualHost example for Apache:

.. code-block:: apache

		<VirtualHost *:80>
			ServerAdmin admin@mail.com
			ServerName test.local

			DocumentRoot /www/phalconeye/www/public
			ErrorLog /www/phalconeye/logs/errors.log
			CustomLog /www/phalconeye/logs/access.log combined

			<Directory "/www/phalconeye/www/public">
				Options Indexes FollowSymLinks
				AllowOverride All
				Order allow,deny
				Allow from all
			</Directory>
		</VirtualHost>

5. If you have installed the CMS into a subdirectory (eg. http://youhost.com/phalconeye/),
   you will also need to edit configuration in /app/config/development/application.php.
   Change 'baseUrl' to your subdirectory path (ie. '/phalconeye/').
6. Restart Apache server and browse to http://youhost.com/
7. Visit the website follow the installation instructions.