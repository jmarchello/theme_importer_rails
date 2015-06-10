require "theme_importer_rails/file_sorter"
require "theme_importer_rails/file_editor"
require "fileutils"
require "sass/plugin/rack"


FONT_EXTENSIONS = %w(.eot .svg .ttf .woff .otf .woff2)
IMAGE_EXTENSIONS = %w(.png .jpg .jpeg .gif)

module ThemeImporterRails
  def self.import_theme(theme_origin)
    sorter = FileSorter.new(theme_origin)
    puts "finding asset files..."
    sorter.find_css
    sorter.find_sass
    sorter.find_js
    sorter.find_font_files
    sorter.find_images
    puts "done!"
    puts "sorting asset files..."
    sorter.move_css_files
    sorter.compile_and_move_sass
    sorter.move_js_files
    sorter.move_font_files
    sorter.move_images
    puts "done!"

    puts "generating manifest files..."
    sorter.generate_css_manifest
    sorter.generate_js_manifest
    puts "done!"

    puts "editing asset urls in css files..."
    editor = FileEditor.new
    sorter.css_files.each { |file| editor.edit_urls_in_css_file("#{Rails.root}/vendor/assets/imported_theme/stylesheets/#{File.basename(file)}")}
    puts "done!"


    puts 'Theme imported successfully!'
  end

  def self.clean
    FileUtils.rm_rf("#{Rails.root}/vendor/assets/imported_theme") if Dir.exist?("#{Rails.root}/vendor/assets/imported_theme")
    FileUtils.rm_rf("#{Rails.root}/public/assets/imported_theme") if Dir.exist?("#{Rails.root}/public/assets/imported_theme")
  end

  class Tasks < Rails::Railtie
    rake_tasks do
      Dir[File.join(File.dirname(__FILE__),'tasks/*.rake')].each { |f| load f }
    end
  end

end
