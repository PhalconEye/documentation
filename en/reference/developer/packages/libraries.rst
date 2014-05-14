Libraries
=========
Libraries - your code (or vendor) for some specific tasks.

For example, you will need mail library. You can use existing mail libraries (and add your wrapper) or write your own.
Let's say, you will use SwiftMailer (or other, doesn't matter). Library structure can be like this:

.. code-block:: text

    ./libraries/
    └── Mail
        ├── vendor          // Here you can put your SwiftMailer.
        └── Wrapper.php     // Wrapper written by you.

In that case, if you will create such library, your can access it via Mail\\Wrapper::factory(). It means, that all classes inside
subdirectories of libraries directory will be places in namespace of it's subdirectory name:

.. code-block:: text

    ./libraries/
    ├── Mail
    │    ├── ..
    │    └── Wrapper.php     // Mail\Wrapper::factory()
    └── Some
         ├── New
         │    └── Class      // Some\New\Class::factory()
         └── Class.php       // Some\Class::factory()

Note: "factory" method is just for example, you can use any structure you want inside your library.