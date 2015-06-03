require "theme_importer_rails/file_sorter"
require "theme_importer_rails/file_editor"


FONT_EXTENSIONS = %w(.eot .svg .ttf .woff .otf .woff2)
IMAGE_EXTENSIONS = %w(.png .jpg .jpeg .gif)

module ThemeImporterRails
  def self.import_theme(theme_origin)
    sorter = FileSorter.new(theme_origin)
    sorter.find_css
    sorter.find_js
    sorter.find_font_files
    sorter.find_images
    sorter.move_css_files
    sorter.move_js_files
    sorter.move_font_files
    sorter.move_images

    editor = FileEditor.new
    sorter.css_files.each { |file| editor.edit_urls_in_css_file("#{Rails.root}/vendor/assets/imported_theme/stylesheets/#{File.basename(file)}")}

  end
end
