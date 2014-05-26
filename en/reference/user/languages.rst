Languages
=========
Languages management allows to edit languages and translations.

.. image:: /images/languages_1.png
    :align: center

Compilation
-----------
Language management is possible and simple only coz of database storage. But in production mode database using as translations
storage is very bad for performance. So in production mode compiled version of translations is used. Compiled version is php file with all
translations in it. To compile all languages just push on button "Compile languages" and wait until success message.

New Language
------------
To create new language - click on "Create new language" in top navigation.

.. image:: /images/languages_2.png
    :align: center

Fields description:

    **Name** - name of the language in system, can be any that you prefer.

    **Language** - 2 symbols of language, if English - "en", German - "de", Russian - "ru", etc.

    **Locale** - 5 symbols of locale, for example: en_US or en_EN. You can have two languages "en" with different locales.

    **Icon** - not mandatory but can be used by some modules or widgets. Icon can represent language country flag.

Export
------

.. image:: /images/languages_3.png
    :align: center

Export allows to move languages to other system. Scope is defining logical separation of the language. It means that you will
export language translations only for specific scope (e.g. blog - will be exported only translations used in Blog module).

After pushing button "Export" in Export form you will download a JSON file with translations that can be used in import.

Import
------
Import allows to add new translations and languages. Push button "Import" and select valid JSON file with translations.
After short period of time translations will be imported and you will see message about added record count. Don't forget to compile them.

Manage Translations
-------------------
You can manage translation by clicking "Manage" link near language row.

.. image:: /images/languages_4.png
    :align: center

#. Show only untranslated rows.
#. Synchronize current language with english. English language is default in system and all text written in the code are on english. So when system collection the translations their automatically appears in English languages (BTW this is happening automatically in development mode). So, for example current english has 100 translation and your german only 80, to actualize them you can use this button.
#. Search box will search for any occurrences of the text (in original and translated fields).
#. Text marked as red italic - is untranslated text.

Wizard
------
Wizard allows to speedup translation. It shows original text, translation and suggestion. Suggestion is automatically
on en -> current_language by Yandex translation API. By pushing "Next" button you saving translation field to database.

.. image:: /images/languages_5.png
    :align: center