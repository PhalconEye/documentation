Grid System
===========
Grid is table of entities with actions, sorting and filtering.

.. image:: /images/grid.png
    :align: center

Same as in forms here is AbstractGrid and extended CoreGrid (abstract, too):

.. code-block:: php

    <?php

    abstract class CoreGrid extends AbstractGrid
    {
        /**
         * Get grid view name.
         *
         * @return string
         */
        public function getLayoutView()
        {
            return $this->_resolveView('partials/grid/layout');
        }

        /**
         * Get grid item view name.
         *
         * @return string
         */
        public function getItemView()
        {
            return $this->_resolveView('partials/grid/item');
        }

        /**
         * Get grid table body view name.
         *
         * @return string
         */
        public function getTableBodyView()
        {
            return $this->_resolveView('partials/grid/body');
        }

        /**
         * Resolve view.
         *
         * @param string $view   View path.
         * @param string $module Module name (capitalized).
         *
         * @return string
         */
        protected function _resolveView($view, $module = 'Core')
        {
            return '../../' . $module . '/View/' . $view;
        }
    }

Usage in controller:

.. code-block:: php

    <?php

    public function indexAction()
    {
        $grid = new UserGrid($this->view);
        if ($response = $grid->getResponse()) {
            return $response;
        }
    }

    // yep.. that's all )).

Source
------
Grid has source. Source can be QueryBuilder or Array. You can implement you own SourceResolver to handle different data.

Usual QueryBuilder:

.. code-block:: php

    <?php

    // Method getSource is required.
    public function getSource()
    {
        $builder = new Builder();
        $builder
            ->columns(['u.*', 'r.name'])
            ->addFrom('User\Model\User', 'u')
            ->leftJoin('User\Model\Role', 'u.role_id = r.id', 'r')
            ->orderBy('u.id DESC');

        return $builder;
    }

Array usage:

.. code-block:: php

    <?php

    public function getSourceResolver()
    {
        return new ArrayResolver($this);
    }

    public function getSource()
    {
        $data = [['row1_column1' => 1, 'row1_column2' => 2], ['row2_column1' => 3, 'row2_column2' => 4]];
        return $data;
    }

Columns
-------
Columns must be defined per required method _initColumns(). Columns definition contains:

    * id (name of field in query builder or in array).
    * label - Column label.
    * sortable - flag that defines if column is sortable.
    * type - column bind type parameter (see Phalcon\Db\Column::BIND_*).
    * filter - flag that defines if this column can be filtered.
    * use_having - flag that allows to build query using HAVING operator (in case query contains JOINS and joined has conditions).
    * condition_like -  flag that allows to use LIKE operator in condition.
    * output_logic - this allows to change output behaviour, accepts function closure.

Example:

.. code-block:: php

    <?php

    protected function _initColumns()
    {

        $this
            // Add simple text column, this means, that in filtering will be available text field.
            ->addTextColumn(
                'u.id',   // field name in query
                'ID',     // Label
                [
                    self::COLUMN_PARAM_TYPE => Column::BIND_PARAM_INT,     // Bind parameter, need to escape SQL injections.
                    self::COLUMN_PARAM_OUTPUT_LOGIC =>                     // Special output logic.
                        function (GridItem $item, $di) {
                            $url = $di->get('url')->get(
                                ['for' => 'admin-users-view', 'id' => $item['u.id']]
                            );
                            return sprintf('<a href="%s">%s</a>', $url, $item['u.id']);
                        }
                ]
            )
            ->addTextColumn('u.username', 'Username')
            ->addTextColumn('u.email', 'Email')
            ->addSelectColumn(
                'r.name',
                'Role',
                ['hasEmptyValue' => true, 'using' => ['name', 'name'], 'elementOptions' => Role::find()],
                [
                    self::COLUMN_PARAM_USE_HAVING => false,                 // Don't use HAVING
                    self::COLUMN_PARAM_USE_LIKE => false,                   // And don't use LIKE, '==' operator will be used ('=' IN SQL).
                    self::COLUMN_PARAM_OUTPUT_LOGIC =>
                        function (GridItem $item) {
                            return $item['name'];
                        }
                ]
            )
            ->addTextColumn('u.creation_date', 'Creation Date');
    }

Actions
-------
Actions also can be defined:

.. code-block:: php

    <?php

    public function getItemActions(GridItem $item)
    {
        $actions = [
            'Manage' => ['href' => ['for' => 'admin-languages-manage', 'id' => $item['id']]],
            'Export' => [
                'href' => ['for' => 'admin-languages-export', 'id' => $item['id']],
                'attr' => ['data-widget' => 'modal']
            ],
            'Wizard' => [
                'href' => ['for' => 'admin-languages-wizard', 'id' => $item['id']],
                'attr' => ['data-widget' => 'modal']
            ],
            '|' => [],
            'Edit' => ['href' => ['for' => 'admin-languages-edit', 'id' => $item['id']]],
            'Delete' => [
                'href' => [
                    'for' => 'admin-languages-delete', 'id' => $item['id']
                ],
                'attr' => ['class' => 'grid-action-delete']
            ]
        ];

        if (
            $item->getObject()->language == Config::CONFIG_DEFAULT_LANGUAGE &&
            $item->getObject()->locale == Config::CONFIG_DEFAULT_LOCALE
        ) {
            unset($actions['|']);
            unset($actions['Edit']);
            unset($actions['Wizard']);
            unset($actions['Delete']);
        }

        return $actions;
    }

getItemActions(GridItem $item) must return array of actions with parameters. 'href' is required parameter, 'attr' is optional.

Grid View
---------
Grid view divided on three parts: layout (main layout, starting from <table> tag), body (tbody tag), item (td tag with actions).
Each view can be overridden in grid class.

Layout example:

.. code-block:: html+jinja

    <table id="{{ grid.getId() }}" class="table grid-table" data-widget="grid">
        <thead>
        <tr>
            {% for name, column in grid.getColumns() %}
                <th>
                    {% if column[constant('\Engine\Grid\AbstractGrid::COLUMN_PARAM_SORTABLE')] is defined and column[constant('\Engine\Grid\AbstractGrid::COLUMN_PARAM_SORTABLE')] %}
                        <a href="javascript:;" class="grid-sortable" data-sort="{{ name }}" data-direction="">
                            {{ column[constant('\Engine\Grid\AbstractGrid::COLUMN_PARAM_LABEL')] |i18n }}
                        </a>
                    {% else %}
                        {{ column[constant('\Engine\Grid\AbstractGrid::COLUMN_PARAM_LABEL')] |i18n }}
                    {% endif %}
                </th>
            {% endfor %}
            {% if grid.hasActions() %}
                <th class="actions">{{ 'Actions' |i18n }}</th>
            {% endif %}
        </tr>
        {% if grid.hasFilterForm() %}
            <tr class="grid-filter">
                {% for column in grid.getColumns() %}
                    <th>
                        {% if column[constant('\Engine\Grid\AbstractGrid::COLUMN_PARAM_FILTER')] is defined and instanceof(column[constant('\Engine\Grid\AbstractGrid::COLUMN_PARAM_FILTER')], 'Engine\Form\AbstractElement') %}
                            {% set element = column[constant('\Engine\Grid\AbstractGrid::COLUMN_PARAM_FILTER')] %}
                            {{ element.setAttribute('autocomplete', 'off').render() }}
                        {% endif %}
                        <div class="clear-filter"></div>
                    </th>
                {% endfor %}
                <th class="actions">
                    <button class="btn btn-filter btn-primary">{{ 'Filter' |i18n }}</button>
                    <button class="btn btn-warning">{{ 'Reset' |i18n }}</button>
                </th>
            </tr>
        {% endif %}
        </thead>
        {{ partial(grid.getTableBodyView(), ['grid': grid]) }}
    </table>