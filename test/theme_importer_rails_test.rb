require 'test_helper'

class ThemeImporterRailsTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ThemeImporterRails
  end

  test "importing a theme" do
    sorter = FileSorter.new('test/theme')
    sorter.find_css
    sorter.find_js
    sorter.find_font_files
    sorter.find_images
    css_files = sorter.instance_variable_get(:@css_files)
    js_files = sorter.instance_variable_get(:@js_files)
    font_files = sorter.instance_variable_get(:@font_files)
    images = sorter.instance_variable_get(:@images)
    ThemeImporterRails.import_theme('test/theme')
    
    css_files.each do |css_file|
      file_name = File.basename(css_file)
      assert(File.exists?("#{Rails.root}/vendor/assets/imported_theme/stylesheets/#{file_name}"), "file #{file_name} is not found in stylesheets")
    end

    js_files.each do |js_file|
      file_name = File.basename(js_file)
      assert(File.exists?("#{Rails.root}/vendor/assets/imported_theme/javascripts/#{file_name}"), "file #{file_name} is not found in javascripts")
    end

    font_files.each do |font_file|
      file_name = File.basename(font_file)
      assert(File.exists?("#{Rails.root}/public/assets/imported_theme/fonts/#{file_name}"), "file #{file_name} is not found in fonts")
    end

    images.each do |image|
      file_name = File.basename(image)
      assert(File.exists?("#{Rails.root}/public/assets/imported_theme/images/#{file_name}"), "file #{file_name} is not found in images")
    end

  end
end
