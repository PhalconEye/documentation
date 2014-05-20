Themes
======
Theme package - archive with \*.less, \*.css and images. Respects folder structure.

Theme must include constants.less and theme.less files. Other \*.less files you can separate them via LESS compiler logic.
All \*.less files inside themes compiles automatically.
Constants files is required to handle style structure for modules, that can use this style manners for their html.

Constants from constants.less can be used in your modules and widgets to allow them use current style respecting theme changing by end user.