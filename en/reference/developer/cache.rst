Cache
=====
Cache is required to improve performance. PhalconEye has 4 types of cache:

+--------------+-------------------------------------------------------------------------------------------------------+
| Name         | Description                                                                                           |
+==============+=======================================================================================================+
| viewCache    | Used by Phalcon to cache views.                                                                       |
|              | http://docs.phalconphp.com/en/latest/reference/views.html#caching-view-fragments                      |
+--------------+-------------------------------------------------------------------------------------------------------+
| cacheOutput  | Used by developer to cache output data (piece of HTML or text).                                       |
+--------------+-------------------------------------------------------------------------------------------------------+
| cacheData    | Used by developer to cache data (rows, arrays, etc).                                                  |
+--------------+-------------------------------------------------------------------------------------------------------+
| modelsCache  | Used by Phalcon to cache ORM's data.                                                                  |
|              | http://docs.phalconphp.com/en/latest/reference/models-cache.html                                      |
+--------------+-------------------------------------------------------------------------------------------------------+

When PhalconEye in development mode all cache will be created through Dummy layer that will not store any data.

About cache system read in |phalcon_documentation|.

.. |phalcon_documentation| raw:: html

   <a href="http://docs.phalconphp.com/en/latest/reference/cache.html" target="_blank">Phalcon documentation</a>