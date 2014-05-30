Cache
=====
Cache is required to improve performance. PhalconEye has 4 types of cache:

+--------------+-------------------------------------------------------------------------------------------------------+
| Name         | Description                                                                                           |
+==============+=======================================================================================================+
| viewCache    | Used by Phalcon to cache views.                                                                       |
|              | http://docs.phalconphp.com/en/latest/reference/views.html#caching-view-fragments                      |
+--------------+-------------------------------------------------------------------------------------------------------+
| cacheOutput  | Used by developer to cache output data (pieces of HTML or text).                                      |
+--------------+-------------------------------------------------------------------------------------------------------+
| cacheData    | Used by developer to cache data (rows, arrays, etc).                                                  |
+--------------+-------------------------------------------------------------------------------------------------------+
| modelsCache  | Used by Phalcon to cache ORM's data.                                                                  |
|              | http://docs.phalconphp.com/en/latest/reference/models-cache.html                                      |
+--------------+-------------------------------------------------------------------------------------------------------+

In development mode all cache data will be handled with non-persistent Dummy layer which does not store any data.

You can read more about cache system in |phalcon_documentation|.

.. |phalcon_documentation| raw:: html

   <a href="http://docs.phalconphp.com/en/latest/reference/cache.html" target="_blank">Phalcon documentation</a>