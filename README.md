# Theme Importer

[![Gem Version](https://badge.fury.io/rb/theme_importer_rails.svg)](http://badge.fury.io/rb/theme_importer_rails)

This is a Rails Gem for painlessly importing themes into the asset pipeline. This Gem saves you valuable time by allowing you to import a theme in two simple steps.

## Installation

Simply add the gem to your Gemfile:

```ruby
gem 'theme_importer_rails'
```

Then run `bundle install`.

Or you can run `gem install theme_importer_rails`.

## Usage

This gem gives you a rake task to import a theme from your local filesystem. To import a theme run the following:

```bash
$ rake theme_importer:import[path/to/theme/directory]
```

The task will run, loading all the necessary files into the asset pipeline. You'll notice that the original theme directory is unchanged.

Finally, add the imported theme to your manifest files like so:

In `application.css`
```
*= require imported_theme
```
and in `application.js`
```
//= require imported_theme
```

#### Clean out a theme
To clean out the imported files, simply run:

```bash
$ rake theme_importer:clean
```

## The dirty details

When the import task runs, it does the following:

1. Scans the theme directory for all CSS, SASS, JavaScript, images, and fonts.

2. Compiles SASS files into CSS, and moves all CSS files to `vender/assets/imported_theme/stylesheets`.

3. Moves JavaScript files into `vender/assets/imported_theme/javascripts`

4. Moves fonts into `public/assets/imported_theme/fonts`

5. Moves images into `public/assets/imported_theme/images`

6. Generates manifest files for stylesheets and javascripts.
