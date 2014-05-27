Languages
=========

This area enables Administrators to create custom translations for elements on the website
such as buttons, commands, alerts and so on...

.. image:: /images/languages_1.png
    :align: center

Adding a language
-----------------

To add a new language - click "Create new language" from top navigation.

.. image:: /images/languages_2.png
    :align: center

Fields description:

    **Name** - system name of the language, whatever you prefer

    **Language** - 2 character language code (eg. English - "en", German - "de", Russian - "ru")

    **Locale** - 5 character locale code (eg. en_US or en_EN). You can create two locales for the same languages.

    **Icon** - not mandatory but might be used by some modules or widgets. Icon can represent a country flag.

Performance note
----------------

Custom translations are kept in database for simplicity of development.
In production mode, however, translations are compiled into a php file to avoid database performance overhead.
To re-compile available translations click "Compile languages" and wait until it completes.

Export
------

.. image:: /images/languages_3.png
    :align: center

You can easily export a language you have created into a JSON file and import it into another instance of PhalconEye.
Scope defines logical separation of the language to export only certain part of translations
(e.g. Blog - only translations used in Blog module will be exported).

Import
------

Enables administrators to import translations for other languages. Simply, click "Import" and select a JSON file
file with translations. After short period of time translations will be imported and you will see message about the result.
Once finished, do not forget to compile them!

Manage Translations
-------------------

You can manage translation by clicking "Manage" within a row.

.. image:: /images/languages_4.png
    :align: center

#. Show only untranslated rows.
#. Synchronize current language with English. English is the default system language and all internal contents are in English. When system generates translations they are automatically added to English subset (it happens automatically in development mode). If, for instance, current subset of English language has got 100 translations and your German language only 80, use synchronization to copy untranslated records to the German subset.
#. Search box will search for any occurrences of the text (in both original and translated subsets).
#. Italic Text marked in red - is untranslated.

Wizard
------

Spped up translations with wizard! It will give you the original text, translation and a suggestion.
The suggestion is automated on en -> current_language by Yandex translation API.
By clicking "Next" button you will save the translation field to database.

.. image:: /images/languages_5.png
    :align: center
