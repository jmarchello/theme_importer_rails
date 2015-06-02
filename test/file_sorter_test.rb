require "test_helper"
require "fileutils"

class FileSorterTest < ActiveSupport::TestCase
  def setup
    @theme_orig = "test/theme/"
  end

  def teardown
    if Dir.exist?("#{Rails.root}/vender/assets/imported_theme")
      FileUtils.rm_rf("#{Rails.root}/vender/assets/imported_theme")
    end
  end

  def test_find_css
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.find_css
    css_files = file_sorter.instance_variable_get(:@css_files)
    refute_empty(css_files)
  end

  def test_find_css_returns_only_css
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.find_css
    css_files = file_sorter.instance_variable_get(:@css_files)
    css_files.each do |file|
      assert(File.extname(file) == ".css" || File.extname(file) == ".scss", "file #{file} is not a css or scss file")
    end
  end

  def test_find_js
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.find_js
    js_files = file_sorter.instance_variable_get(:@js_files)
    refute_empty(js_files)
  end

  def test_find_js_returns_only_js
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.find_js
    js_files = file_sorter.instance_variable_get(:@js_files)
    js_files.each do |file|
      assert(File.extname(file) == ".js" || File.extname(file) == ".coffee", "file #{file} is not a js or coffee file")
    end
  end

  def test_create_imported_theme_dir
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.create_imported_theme_dir
    assert(Dir.exists?("#{Rails.root}/vender/assets"))
    assert(Dir.exists?("#{Rails.root}/vender/assets/imported_theme"))
  end

  def test_move_css_files
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.find_css
    css_files = file_sorter.instance_variable_get(:@css_files)
    file_sorter.move_css_files
    css_files.each do |file|
      filename = File.basename(file)
      assert(File.exists?("#{Rails.root}/vender/assets/imported_theme/stylesheets/#{filename}"), "file #{filename} is not in stylesheets directory.")
    end
  end

  def test_move_js_files
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.find_js
    js_files = file_sorter.instance_variable_get(:@js_files)
    file_sorter.move_js_files
    js_files.each do |file|
      filename = File.basename(file)
      assert(File.exists?("#{Rails.root}/vender/assets/imported_theme/javascripts/#{filename}"), "file #{filename} is not in javascripts directory.")
    end
  end

  def test_generate_css_manifest
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.find_css
    file_sorter.generate_css_manifest
    assert(FileUtils.compare_file("test/model_css_manifest.css" ,"#{Rails.root}/vender/assets/imported_theme/imported_theme.css"))
  end

  def test_generate_js_manifest
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.find_js
    file_sorter.generate_js_manifest
    assert(FileUtils.compare_file("test/model_js_manifest.js" ,"#{Rails.root}/vender/assets/imported_theme/imported_theme.js"))
  end
end
