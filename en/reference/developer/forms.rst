Forms
=====
Forms allows to handle user data. Forms contains such features:

    * Fieldsets.
    * Conditions.
    * Elements and containers based (OOP objects).
    * Fast methods for elements.
    * Views as partial (separated logic for elements, containers, etc).
    * Multiply entities support.
    * Validation according to form validation and entities validation.
    * Simple entity form.
    * Text form.
    * File form.

Form example:

.. code-block:: php

    <?php

    namespace Core\Form\Admin\Setting;

    use Core\Form\CoreForm;

    /**
     * Performance settings.
     *
     * @category  PhalconEye
     * @package   Core\Form\Admin\Setting
     * @author    Ivan Vorontsov <ivan.vorontsov@phalconeye.com>
     * @copyright 2013-2014 PhalconEye Team
     * @license   New BSD License
     * @link      http://phalconeye.com/
     */
    class Performance extends CoreForm
    {
        /**
         * Initialize form.
         *
         * @return void
         */
        public function initialize()
        {
            $this->setTitle('Performance settings');

            $this->addContentFieldSet()
                ->addText('prefix', 'Cache prefix', 'Example: "pe_"', 'pe_')
                ->addText(
                    'lifetime',
                    'Cache lifetime',
                    'This determines how long the system will keep cached data before
                        reloading it from the database server.
                        A shorter cache lifetime causes greater database server CPU usage,
                        however the data will be more current.',
                    86400
                )
                ->addSelect(
                    'adapter',
                    'Cache adapter',
                    'Cache type. Where cache will be stored.',
                    [
                        0 => 'File',
                        1 => 'Memcached',
                        2 => 'APC',
                        3 => 'Mongo'
                    ],
                    0
                )

                /**
                 * File options
                 */
                ->addText('cacheDir', 'Files location', null, ROOT_PATH . '/app/var/cache/data/')

                /**
                 * Memcached options.
                 */
                ->addText('host', 'Memcached host', null, '127.0.0.1')
                ->addText('port', 'Memcached port', null, '11211')
                ->addCheckbox('persistent', 'Create a persistent connection to memcached?', null, 1, true, 0)

                /**
                 * Mongo options.
                 */
                ->addText(
                    'server',
                    'A MongoDB connection string',
                    null,
                    'mongodb://[username:password@]host1[:port1][,host2[:port2],...[,hostN[:portN]]]'
                )
                ->addText('db', 'Mongo database name', null, 'database')
                ->addText('collection', 'Mongo collection in the database', null, 'collection')

                /**
                 * Other.
                 */
                ->addCheckbox('clear_cache', 'Clear cache', 'All system cache will be cleaned.', 1, false, 0);

            $this->addFooterFieldSet()->addButton('save');

            $this->addFilter('lifetime', self::FILTER_INT);
            $this->_setConditions();
        }

        /**
         * Validates the form.
         *
         * @param array $data               Data to validate.
         * @param bool  $skipEntityCreation Skip entity creation.
         *
         * @return boolean
         */
        public function isValid($data = null, $skipEntityCreation = false)
        {
            if (!$data) {
                $data = $this->getDI()->getRequest()->getPost();
            }

            if (isset($data['adapter']) && $data['adapter'] == '0') {
                if (empty($data['cacheDir']) || !is_dir($data['cacheDir'])) {
                    $this->addError('Files location isn\'t correct!');

                    return false;
                }
            }

            return parent::isValid($data, $skipEntityCreation);
        }

        /**
         * Set form conditions.
         *
         * @return void
         */
        protected function _setConditions()
        {
            $content = $this->getFieldSet(self::FIELDSET_CONTENT);

            /**
             * Files conditions.
             */
            $content->setCondition('cacheDir', 'adapter', 0);

            /**
             * Memcached conditions.
             */
            $content->setCondition('host', 'adapter', 1);
            $content->setCondition('port', 'adapter', 1);
            $content->setCondition('persistent', 'adapter', 1);

            /**
             * Mongo conditions.
             */
            $content->setCondition('server', 'adapter', 3);
            $content->setCondition('db', 'adapter', 3);
            $content->setCondition('collection', 'adapter', 3);
        }
    }

Structure
---------
Root form class is abstract. So you can't create it directly. Also it has abstract methods, that identifies form rendering feature.
That's why there is some simple form structure:

.. code-block:: text

    AbstractForm
        |
    CoreForm     EntityForm (trait)
        |
        |------- FileForm
        |
        |------- TextForm

Core form implements all necessary methods:

.. code-block:: php

    <?php

    namespace Core\Form;

    use Engine\Form\AbstractForm;

    /**
     * Main core form.
     *
     * @category  PhalconEye
     * @package   Core\Form
     * @author    Ivan Vorontsov <ivan.vorontsov@phalconeye.com>
     * @copyright 2013-2014 PhalconEye Team
     * @license   New BSD License
     * @link      http://phalconeye.com/
     */
    class CoreForm extends AbstractForm
    {
        const
            /**
             * Default layout path.
             */
            LAYOUT_DEFAULT_PATH = 'partials/form/default';

        use EntityForm;

        /**
         * Get layout view path.
         *
         * @return string
         */
        public function getLayoutView()
        {
            return $this->_resolveView(self::LAYOUT_DEFAULT_PATH);
        }

        /**
         * Get element view path.
         *
         * @return string
         */
        public function getElementView()
        {
            return $this->getLayoutView() . '/element';
        }

        /**
         * Get errors view path.
         *
         * @return string
         */
        public function getErrorsView()
        {
            return $this->getLayoutView() . '/errors';
        }

        /**
         * Get notices view path.
         *
         * @return string
         */
        public function getNoticesView()
        {
            return $this->getLayoutView() . '/notices';
        }

        /**
         * Get fieldset view path.
         *
         * @return string
         */
        public function getFieldSetView()
        {
            return $this->getLayoutView() . '/fieldSet';
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

Text and file form extended from it and used for text rendering and file uploading features respectively.
Entity trait used for forms that must be created according to some entity. Read more about each form type below.

Elements
--------
Elements are objects and form/fieldset is a container for these objects. So you can add element to form by creating it and adding:

.. code-block:: php

    <?php

    // Create element.
    $el = new Text("someName", [/*options*/], [/*attributes*/]);

    // Add element with order 1001.
    $this->add($el, 1001);

But this is a bit hard. So, there are exists some methods for element creation:

    * addHtml
    * addButton
    * addButtonLink
    * addText
    * addTextArea
    * addCkEditor
    * addPassword
    * addHidden
    * addHeading
    * addFile
    * addRemoteFile
    * addCheckbox
    * addRadio
    * addMultiCheckbox
    * addSelect
    * addMultiSelect

Default options of elements (not all allowed, and this is not a complete list, options can be added manually by element):

+--------------+----------------------------------------------------------------------------------------------------------+
| Name         | Description                                                                                              |
+==============+==========================================================================================================+
| label        | Label content for element                                                                                |
+--------------+----------------------------------------------------------------------------------------------------------+
| description  | Description text for element                                                                             |
+--------------+----------------------------------------------------------------------------------------------------------+
| required     | Mark element as required (you can't submit form without data for this element).                          |
+--------------+----------------------------------------------------------------------------------------------------------+
| emptyAllowed | Mark element as required with non empty value (you can't submit form with empty string for this element).|
+--------------+----------------------------------------------------------------------------------------------------------+
| ignore       | Ignore element in validation and values, ignores it at backend, it will be skipped. Example: buttons.    |
+--------------+----------------------------------------------------------------------------------------------------------+
| htmlTemplate | Html template for element.                                                                               |
+--------------+----------------------------------------------------------------------------------------------------------+
| defaultValue | Default value of element. Example: checkbox, user set (un)checked state, but default value is '1'.       |
+--------------+----------------------------------------------------------------------------------------------------------+

Non-default options:

+---------------+-----------------+------------+---------------------------------------------------------------------------------------------------------------+
| Element Name  | Option Name     | Type       |Description                                                                                                    |
+===============+=================+============+===============================================================================================================+
| Button        | isSubmit        | Boolean    | Flag, that adds submit feature to the button. If it 'false' - button will not be able to submit the form.     |
+---------------+-----------------+------------+---------------------------------------------------------------------------------------------------------------+
| Checkbox      | checked         | Mixed      | If something is set to this option (true, 'checked', etc) an additional attribute checked="checked" will be   |
|               |                 |            | added. If it is null, nothing will be added.                                                                  |
+---------------+-----------------+------------+---------------------------------------------------------------------------------------------------------------+
| CkEditor      | elementOptions  | Array      | Array of options for CkEditor control.                                                                        |
+---------------+-----------------+------------+---------------------------------------------------------------------------------------------------------------+
| File          | isImage         | Boolean    | Flag for image, if it is true, control will add additional url checks for value of this control.              |
|               |                 |            | Also some additional check can be applied for this control, marked as image.                                  |
+---------------+-----------------+------------+---------------------------------------------------------------------------------------------------------------+
| Heading       | tag             | String     | Tag of heading. By default: 'h2'.                                                                             |
+---------------+-----------------+------------+---------------------------------------------------------------------------------------------------------------+
| MultiCheckbox,| elementOptions  | Array      | Associated array of key=>value, data for control.                                                             |
| Radio,        |                 |            |                                                                                                               |
| Select        |                 |            |                                                                                                               |
|               +-----------------+------------+---------------------------------------------------------------------------------------------------------------+
|               | disabledOptions | Array      | Array of keys that must be marked, as disabled (css attr).                                                    |
|               +-----------------+------------+---------------------------------------------------------------------------------------------------------------+
|               | using           | Resultset  | Phalcon ResultSet, Model::findAll().                                                                          |
+---------------+-----------------+------------+---------------------------------------------------------------------------------------------------------------+
| Select        | hasEmptyValue   | Boolean    | Flag for empty value by default, this is empty select option.                                                 |
+---------------+-----------------+------------+---------------------------------------------------------------------------------------------------------------+

List of all elements, their options and attributes:

+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| Name         | Description                         | Allowed Options          | Default Options          | Default Attributes                                       |
+==============+=====================================+==========================+==========================+==========================================================+
| Button       | Button element.                     | 'htmlTemplate', 'label', | 'isSubmit' => true       | * 'id' => $this->getName()                               |
|              |                                     | 'isSubmit'               |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          |                                                          |
|              |                                     |                          |                          | If 'isSubmit' == true                                    |
|              |                                     |                          |                          |                                                          |
|              |                                     |                          |                          | * 'type' => 'submit'                                     |
|              |                                     |                          |                          | * 'class' => 'btn btn-primary'                           |
|              |                                     |                          |                          |                                                          |
|              |                                     |                          |                          | else                                                     |
|              |                                     |                          |                          |                                                          |
|              |                                     |                          |                          | * 'class' => 'btn'                                       |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| ButtonLink   | Button as link, e.g.: back link.    | 'htmlTemplate', 'label'  | ---                      | * 'id' => $this->getName()                               |
|              |                                     |                          |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          | * 'class' => 'btn form_link_button'                      |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| Checkbox     | Html input of type "checkbox".      | all default options,     | ---                      | * 'id' => $this->getName()                               |
|              |                                     | 'checked'                |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          | * 'class' => ''                                          |
|              |                                     |                          |                          | * 'type' => 'checkbox'                                   |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| CkEditor     | CkEditor control.                   | all default options,     | ---                      | * 'id' => $this->getName()                               |
|              |                                     | 'elementOptions'         |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          | * 'class' => 'form-control'                              |
|              |                                     |                          |                          | * 'data-widget' => 'ckeditor'                            |
|              |                                     |                          |                          | * 'data-name' => $this->getName()                        |
|              |                                     |                          |                          | * 'data-options' => 'elementOptions' option              |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| File         | Html input of type "file".          | all default options,     | ---                      | * 'id' => $this->getName()                               |
|              |                                     | 'isImage'                |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          | * 'class' => 'form-control'                              |
|              |                                     |                          |                          | * 'type' => 'file'                                       |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| Heading      | Simple text output as heading.      | 'htmlTemplate', 'tag'    | 'tag' => 'h2'            | * 'id' => $this->getName()                               |
|              |                                     |                          |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          | * 'class' => 'form_element_heading'                      |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| Hidden       | Html input of type "hidden".        | all default options.     | ---                      | * 'id' => $this->getName()                               |
|              |                                     |                          |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          | * 'class' => 'form-control'                              |
|              |                                     |                          |                          | * 'type' => 'hidden'                                     |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| Html         | Render raw html. It's value is html.| ---                      | ---                      | ---                                                      |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| MultiCheckbox| Multi checkbox control.             | all default options,     | ---                      | * 'id' => $this->getName()                               |
|              |                                     | 'elementOptions',        |                          | * 'name' => $this->getName()                             |
|              |                                     | 'disabledOptions',       |                          | * 'required' => true/false                               |
|              |                                     | 'using'                  |                          | * 'class' => ''                                          |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| Password     | Html input of type "password".      | all default options.     | ---                      | * 'id' => $this->getName()                               |
|              |                                     |                          |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          | * 'class' => 'form-control'                              |
|              |                                     |                          |                          | * 'type' => 'password'                                   |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| Radio        | Radiobox control.                   | all default options,     | ---                      | * 'id' => $this->getName()                               |
|              |                                     | 'elementOptions',        |                          | * 'name' => $this->getName()                             |
|              |                                     | 'disabledOptions',       |                          | * 'required' => true/false                               |
|              |                                     | 'using'                  |                          | * 'class' => ''                                          |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| RemoteFile   | File, located at file storage,      | all default options,     | ---                      | ---                                                      |
|              | opens modal dialog in Pydio for     | 'buttonTitle'            |                          |                                                          |
|              | file selection. Select url to file. |                          |                          |                                                          |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| Select       | Html <select> control.              | all default options,     | ---                      | * 'id' => $this->getName()                               |
|              |                                     | 'elementOptions',        |                          | * 'name' => $this->getName()                             |
|              |                                     | 'disabledOptions',       |                          | * 'required' => true/false                               |
|              |                                     | 'using', 'hasEmptyValue' |                          | * 'class' => 'form-control'                              |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| Text         | Html input of type "text".          | all default options.     | ---                      | * 'id' => $this->getName()                               |
|              |                                     |                          |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          | * 'class' => 'form-control'                              |
|              |                                     |                          |                          | * 'type' => 'text'                                       |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+
| TextArea     | Html <textarea> control.            | all default options.     | ---                      | * 'id' => $this->getName()                               |
|              |                                     |                          |                          | * 'name' => $this->getName()                             |
|              |                                     |                          |                          | * 'required' => true/false                               |
|              |                                     |                          |                          | * 'class' => 'form-control'                              |
+--------------+-------------------------------------+--------------------------+--------------------------+----------------------------------------------------------+

    **Note:** in most cases, when 'htmlTemplate' option is allowed element renders via it.

Fieldsets
---------
Fieldset is a logical and/or visible separation.
By default there are two fieldsets: content and footer. Content is for editable elements and footer is for buttons:

.. code-block:: php

    <?php

    class Create extends CoreForm
    {
         /**
         * Initialize form.
         *
         * @return void
         */
        public function initialize()
        {
            // Add elements to default content field set (field set key is 'form_content').
            $this->addContentFieldSet()
                ->addText('name', 'Name', 'Name must be in lowercase and contains only letters.')
                ->addSelect('type', 'Package type', null, Manager::$allowedTypes)
                ->addText('title');

            // Add buttons to footer (field set key is 'form_footer').
            $this->addFooterFieldSet()
                ->addButton('create')
                ->addButtonLink('cancel', 'Cancel', ['for' => 'admin-packages']);
        }
    }

You can add your fieldsets or access them:

.. code-block:: php

    <?php

    // Get content field set.
    $contentFieldSet = $this->getFieldSet(self::FIELDSET_CONTENT); // self::FIELDSET_CONTENT =  'form_content'

    // Add new field set.
    $fieldSet = new FieldSet('fieldSetName', 'Some legend, if needed', ['class' => 'css-class'], [/*... array of elements...*/]);

    // Add elements.
    // Elements adding methods are the same as for form class.
    $fieldset->add<elementName>(...);

    // Set flag for rendering feature, this will remove html div separation between elements, by default used for buttons at footer.
    $fieldSet->combineElements(true);

    // Adds css attribute to all elements inside fieldset with key: id="fieldSetName_elementName".
    $fieldSet->enableNamedElements(true);

    // Changes all elements css name attribute according to fieldset name: name="fieldSetName[elementName]".
    $fieldSet->enableDataElements(true);

    // Addd fieldset to form with order number 1001.
    $this->addFieldSet($fieldSet, 1001);

Conditions
----------
Conditions allows to set relation between fields.

For example we have 3 fields: select, text and text. Select and text must be visible always, but third text field must be
visible only when select field has some specific value. Conditions allows you to setup such relation:

.. code-block:: php

    <?php

    // Parameters:
    // 1) Field that will be checked on value change. Our "select".
    // 2) Our "third text field" that will be shown/hidden.
    // 3) Value that must be in select to satisfy this condition and show "third text field".
    // 4) Comparison operator, you can find constants in Engine\Form\ConditionResolver. Allowed: ==, !=, >, <, >=, <=.
    //    This operator defines how value of fieldA must be compared to value that you entered in third parameter.
    // 5) Summary operator. That operators also defined in Engine\Form\ConditionResolver. Allowed: 'and', 'or'.
    //    In case when "third text field" also related to "second text field" you can add new condition on that field,
    //    And in that case you will have two conditions, that's why you need to setup result operator - logical AND or OR.
    //    "third text field" will be shown/hidden state depends on result of conditions and their summary result.
    $content->setCondition('fieldA', 'fieldB', 1, '==', 'and');

    // Examples.
    // Preconditions:
    // select with values (1,2,3) - field1.
    // text field - field2.
    // text field - field3.

    // Condition: field3 visible only when field1 has value '2' and field2 has value greater than '15'.
    $content->setCondition('field1', 'field3', 2);  // Comparison by default is '==' and result operator is 'and'.
    $content->setCondition('field2', 'field3', 15, ConditionResolver::COND_CMP_GREATER);

    // Condition: field3 visible when field1 has value '3' or field2 has lower or equivalent to '0'.
    $content->setCondition('field1', 'field3', 3, ConditionResolver::COND_CMP_EQUAL, ConditionResolver::COND_OP_OR);
    $content->setCondition('field2', 'field3', 0, ConditionResolver::COND_CMP_LESS_OR_EQUAL, ConditionResolver::COND_OP_OR);

    // Condition: fieldSet 'footer' visible only when field1 has value '3'.
    $this->setFieldSetCondition(self::FIELDSET_FOOTER, 'field1', 3);

This conditions allows to show/hide fields (all logic based on js, already implemented). Also it's enables/disables validation
for this fields and of course getValues method will return data without fields values if condition wasn't successful.

Form view
---------
AbstractForm class has some abstract methods:

    * getLayoutView    - path to form layout view.
    * getElementView   - element view.
    * getErrorsView    - errors view.
    * getNoticesView   - notices view.
    * getFieldSetView  - view for fieldset.

This methods can be overridden, you can change one part of form view to your own. It means that you can simply change form
style without problems to other forms.

Layout view example:

.. code-block:: html+jinja

    {{ form.openTag() }}
    <div>
        {% if form.getTitle() or form.getDescription() %}
            <div class="form_header">
                <h3>{{ form.getTitle() }}</h3>

                <p>{{ form.getDescription() }}</p>
            </div>
        {% endif %}
        {{ partial(form.getErrorsView(), ['form': form]) }}
        {{ partial(form.getNoticesView(), ['form': form]) }}

        <div class="form_elements">
            {% for element in form.getAll() %}
                {{ partial(form.getElementView(), ['element': element]) }}
            {% endfor %}
        </div>
        <div class="clear"></div>

        {% if form.useToken() %}
            <input type="hidden" name="{{ security.getTokenKey() }}" value="{{ security.getToken() }}">
        {% endif %}
    </div>
    {{ form.closeTag() }}

Entities support
----------------
For example you have blog and you want to create form that will create blogs. You can associate form with entity and
after validation you will have a new blog model.

To associate form with entity you must add it per initialization. In most cases form for creation can be extended for
form that will edit this blogs. So this must be respected:

.. code-block:: php

    <?php

    public function __construct(AbstractModel $entity = null)
    {
        parent::__construct();

        if (!$entity) {
            $entity = new Blog();
        }

        $this->addEntity($entity);
    }

Done! To get your complete blog entity, just get it after validation.

.. code-block:: php

    <?php

    $this->view->form = $form = new CreateForm();
    if (!$this->request->isPost() || !$form->isValid()) {
       return;
    }

    $blog = $form->getEntity();

Note that blog already saved to database. If you don't want to save it automatically, run validation with skip flag:

.. code-block:: php

    <?php

    $this->view->form = $form = new CreateForm();
    if (!$this->request->isPost() || !$form->isValid(null, true)) {
       return;
    }

    $blog = $form->getEntity(); // This entity isn't saved yet.
    $blog->generateSlug();
    $blog->save();

You can add multiple entities:

.. code-block:: php

    <?php

    public function __construct(AbstractModel $entity1 = null, AbstractModel $entity2 = null)
    {
        parent::__construct();

        if (!$entity1) {
            $entity1 = new Blog();
        }

        if (!$entity2) {
            $entity2 = new Tag();
        }

        $this->addEntity($entity1, 'blog');
        $this->addEntity($entity2, 'tag');
    }

    // In controller:

    $blog = $this->getEntity('blog');
    $tag = $this->getEntity('tag');

Validation
----------
Validation is divided. Validation can be defined for form, fieldset, entity. But all this validation is checked independently.
If you like `entity validation`_ you can use it. For form validation internal validation system can be used.

Example:

.. code-block:: php

    <?php

    $formOrFieldSet->getValidation()
                ->add('language', new StringLength(['min' => 2, 'max' => 2]))
                ->add('locale', new StringLength(['min' => 5, 'max' => 5]));
                ->add('email', new Email())
                ->add(
                    'controller',
                    new Regex(
                        [
                            'pattern' => '/$|(.*)Controller->(.*)Action/',
                            'message' => 'Wrong controller name. Example: NameController->someAction'
                        ]
                    )
                );

Filter
------
Filter allows to filter entered values. There are some available filters (constants in AbstractForm class):

    * FILTER_STRING
    * FILTER_EMAIL
    * FILTER_INT
    * FILTER_FLOAT
    * FILTER_ALPHANUM
    * FILTER_STRIPTAGS
    * FILTER_TRIM
    * FILTER_LOWER
    * FILTER_UPPER

About filter system read in `phalcon documentation`_.

.. code-block:: php

    <?php

    $form->addFilter('lifetime', AbstractForm::FILTER_INT);

Text Form
---------
This form is same as CoreForm, but it has changed views. In normal form all elements renders as control, in text form
all element doesn't renders, form takes only their values.

CoreForm element view:

.. code-block:: html+jinja

    <div class="form_element">
        {% if instanceof(element, 'Engine\Form\Element\File') and element.getOption('isImage') and element.getValue() != '/' %}
            <div class="form_element_file_image">
                <img alt="" src="{{ element.getValue() }}"/>
            </div>
        {% endif %}
        {{ element.render() }}
    </div>

TextForm element view:

.. code-block:: html+jinja

    <div class="form_element">
        {% if instanceof(element, 'Engine\Form\Element\File') and element.getOption('isImage') %}
            <div class="form_element_file_image">
                <img alt="" src="{{ element.getValue() }}"/>
            </div>
        {% endif %}
        {{ element.getValue() }}
    </div>



File Form
---------
File form extended from CoreForm and contains additional checks for files validation, image transformation, files management, etc.
FileForm is marked as 'multipart/form-data' and has additional methods.

How to use it:

.. code-block:: php

    <?php

    $form = new FileForm();

    if (!$this->request->isPost() || !$form->isValid()) {
        return;
    }

    // Get all files from request.
    $files = $form->getFiles();

    // Get file of specific field.
    $file = $form->getFiles('name');


Set file validation:

.. code-block:: php

    <?php

    $form->getValidation()->add('file', new MimeType(['type' => 'application/json']));

Set image transformations on upload (performed after validation, if valid):

.. code-block:: php

    <?php

    $form->setImageTransformation(
            'icon',
            [
                'adapter' => 'GD',
                'resize' => [32, 32]
            ]
        );

'adapter' parameter is name of adapter that will be used (GD or Imagick). Other parameters are methods that will be called from
adapter and value is parameters for this method ($gd->resize(32,32);).

Entity Form (Trait)
-------------------
Entity trait was designed as light and simple way of form creation according to model. It applied to CoreForm as trait
and can be accessible through different form types, for example text:

.. code-block:: php

    <?php

    $user = User::findFirst($id);
    $this->view->form = $form = TextForm::factory($user, [], [['password']]);

    $form
        ->setTitle('User details')
        ->addFooterFieldSet()
        ->addButtonLink('back', 'Back', ['for' => 'admin-users']);

EntityForm trait has one method "factory":

.. code-block:: php

    <?php

    /**
     * Create form according to entity specifications.
     *
     * @param AbstractModel[] $entities      Models.
     * @param array           $fieldTypes    Field types.
     * @param array           $excludeFields Exclude fields from form.
     *
     * @return AbstractForm
     */
    public static function factory($entities, array $fieldTypes = [], array $excludeFields = []) {}

Field types parameter allows to change some fields html control (by default <input type="text"/>).
Exclude parameter allows to filter unnecessary fields.



.. _`entity validation`: http://docs.phalconphp.com/en/latest/reference/models.html#validating-data-integrity
.. _`phalcon documentation`: http://docs.phalconphp.com/en/latest/reference/filter.html