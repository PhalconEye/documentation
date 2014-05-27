Performance settings
====================

Performance form allows to setup some improvements in speed.

.. image:: /images/performance_1.png
    :align: center

Fields description:

    **Cache prefix** - cache prefix in system, required if you use shared caching system with other websites.

    **Cache lifetime** - cache TTL (time to live), maximum lifetime of cached data.

    **Cache adapter** - you can select adapter for the cache: file, memcached, apc, mongo. Default is file and others require additional PHP extensions.

    **Clear cache** - select to clear current cache.

If "File" adapter is selected:

    **Files location** - path to a folder where cached data will be stored.

If "Memcached" is selected:

    **Memcached host** - host address of the server.

    **Memcached port** - server port.

    **Create a persistent connection to memcached** - will create per-request persistent connection.

If "APC" adapter has no additional settings.

If "Mongo" adapter is selected:

    **A MongoDB connection string** - mongo connection string (read about mongo).

    **Mongo database name** - database name.

    **Mongo collection in the database** - mongo collection.