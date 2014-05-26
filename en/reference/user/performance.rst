Performance settings
====================
Performance form allows to setup some improvements in speed.

.. image:: /images/performance_1.png
    :align: center

Fields description:

    **Cache prefix** - cache prefix in system, this is required if you have several systems in one cache system.

    **Cache lifetime** - cache TTL (time to live), time that means is that pages will not be regenerated until at least
    this much time has passed and a cache clearing event has happened.

    **Cache adapter** - you can select adapter for the cache: file, memcached, apc, mongo. What select is depends on your
    system.

    **Clear cache** - set flag if you want to clear current cache at form saving.

If "File" adapter is selected:

    **Files location** - location of the cached data files.

If "Memcached" is selected:

    **Memcached host** - host address of the server.

    **Memcached port** - server port.

    **Create a persistent connection to memcached** - will create connection once on request.

If "APC" adapter is selected there no any additional settings.

If "Mongo" adapter is selected:

    **A MongoDB connection string** - mongo connection string (read about mongo).

    **Mongo database name** - database name.

    **Mongo collection in the database** - mongo collection.