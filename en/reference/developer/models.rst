Models
======
Models is database entities. You can read more about them in `Phalcon documentation`_. But PhalconEye has little difference in models: annotations, changed methods (get, getFirst), etc.

Example of model:

.. code-block:: php

    <?php

    namespace Core\Model;

    use Engine\Db\AbstractModel;

    /**
     * Access.
     *
     * @category  PhalconEye
     * @package   Core\Model
     * @author    Ivan Vorontsov <ivan.vorontsov@phalconeye.com>
     * @copyright 2013-2014 PhalconEye Team
     * @license   New BSD License
     * @link      http://phalconeye.com/
     *
     * @Source("access")
     * @BelongsTo("role_id", "User\Model\Role", "id")
     */
    class Access extends AbstractModel
    {
        /**
         * @Primary
         * @Identity
         * @Column(type="string", nullable=false, column="object", size="55")
         */
        public $object;

        /**
         * @Primary
         * @Column(type="string", nullable=false, column="action", size="255")
         */
        public $action;

        /**
         * @Primary
         * @Column(type="integer", nullable=false, column="role_id", size="11")
         */
        public $role_id;

        /**
         * @Column(type="string", nullable=true, column="value", size="25")
         */
        public $value;
    }

Maybe you noticed that access to model fields possible through public modifier of this fields, but not through public methods.
This was made coz of database fields naming conversion. In that case you can fast search through code and understand what field is responsible for.
If you don't like this idea - you can change AbstractModel and add your own magic method (__call) or add methods to your model.

Annotations
-----------
Annotations are needed as metadata and for schema generation feature.

+-----------+-------+-------------------------------------------+------------------------------------------------------------------------------------------------------+
| Name      | Scope | Description                               | Parameters                                                                                           |
+===========+=======+===========================================+======================================================================================================+
| Source    | Class | This is table identity in database.       | One parameter: table name.                                                                           |
+-----------+-------+-------------------------------------------+------------------------------------------------------------------------------------------------------+
| BelongsTo | Class | Setup relation (n:1) to another model.    | 1) Current model's field name.                                                                       |
|           |       |                                           | 2) Class name of model (with namespace).                                                             |
|           |       |                                           | 3) Related model's field name.                                                                       |
|           |       |                                           | 4) Array of options.                                                                                 |
+-----------+-------+-------------------------------------------+------------------------------------------------------------------------------------------------------+
| HasMany   | Class | Setup relation (1:n) to another model.    | 1) Current model's field name.                                                                       |
|           |       |                                           | 2) Class name of model (with namespace).                                                             |
|           |       |                                           | 3) Related model's field name.                                                                       |
|           |       |                                           | 4) Array of options.                                                                                 |
+-----------+-------+-------------------------------------------+------------------------------------------------------------------------------------------------------+
| Primary   | Field | Set field as primary key.                 | ---                                                                                                  |
+-----------+-------+-------------------------------------------+------------------------------------------------------------------------------------------------------+
| Identity  | Field | Set to field identity feature.            | ---                                                                                                  |
+-----------+-------+-------------------------------------------+------------------------------------------------------------------------------------------------------+
| Column    | Field | Specify column options.                   | * "type" - database type of this column (available: integer, string, text, boolean, date, datetime). |
|           |       |                                           | * "nullable" (true/false) - field can be null or not.                                                |
|           |       |                                           | * "column" - column name in database.                                                                |
|           |       |                                           | * "size" - size of column.                                                                           |
+-----------+-------+-------------------------------------------+------------------------------------------------------------------------------------------------------+
| Acl       | Class | This is not related to database...        | * actions - Array named actions, that can be applied for this model.                                 |
|           |       | This allows to add some parameters        | * options - Named options that can be associated with this model.                                    |
|           |       | to admin panel, that will be controlled   |                                                                                                      |
|           |       | for this model by enduser                 | Example:                                                                                             |
|           |       |                                           |                                                                                                      |
|           |       |                                           | .. code-block:: php                                                                                  |
|           |       |                                           |                                                                                                      |
|           |       |                                           |       <?php                                                                                          |
|           |       |                                           |       /**                                                                                            |
|           |       |                                           |         @Acl(actions={"view", "edit", "delete"}, options={"count", "titlePrepend"})                  |
|           |       |                                           |       */                                                                                             |
|           |       |                                           |       class Blog extends AbstractModel                                                               |
|           |       |                                           |       {                                                                                              |
|           |       |                                           |         ...                                                                                          |
|           |       |                                           |       }                                                                                              |
+-----------+-------+-------------------------------------------+------------------------------------------------------------------------------------------------------+

Methods
-------

Here is some useful methods:

.. code-block:: php

    <?php

    // Get table name in database (for queries and other stuff).
    $tableName = Access::getTableName();

    // Methods "get" and "getFirst" was modified with sprintf method inside.
    // Parameters:
    // 1. Condition with placeholders
    // 2. Parameter for condition placeholders.
    // 3. Order by field.
    // 4. Limit.
    $access1 = Access::get('action = "%s" AND value = "%s"', ["edit", "allowed"], "role_id", 100)
    $access2 = Access::getFirst('module = "%s" AND name = "%s"', ["edit", "allowed"], "role_id", 100)

    // Create builder for access table, returns object of Phalcon\Mvc\Model\Query\Builder class. First param - table alias in query builder.
    $builder = Access::getBuilder("tableAlias");

    // Get row identity.
    $id = $access1->getId();

.. _`Phalcon documentation`: http://docs.phalconphp.com/en/latest/reference/models.html