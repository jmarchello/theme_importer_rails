require "minitest/autorun"
require "file_sorter.rb"

class FileSorterTest < Minitest::Test
  def setup
    @vender_dir = "test_app/app/vender"
    @theme_orig = "theme/"
  end

  def test_find_css
    file_sorter = FileSorter.new
    file_sorter.find_css(@theme_orig)
    css_files = file_sorter.instance_variable_get(:@css_files)
    refute_empty(css_files)
  end

  def test_find_css_returns_only_css
    file_sorter = FileSorter.new
    file_sorter.find_css(@theme_orig)
    css_files = file_sorter.instance_variable_get(:@css_files)
    css_files.each do |file|
      assert(File.extname(file) == ".css" || File.extname(file) == ".scss")
    end
  end

  def test_find_js
    file_sorter = FileSorter.new
    file_sorter.find_css(@theme_orig)
    js_files = file_sorter.instance_variable_get(:@js_files)
    refute_empty(js_files)
  end

  def test_find_js_returns_only_js
    file_sorter = FileSorter.new
    file_sorter.find_css(@theme_orig)
    js_files = file_sorter.instance_variable_get(:@js_files)
    js_files.each do |file|
      assert(File.extname(file) == ".js" || File.extname(file) == ".coffee")
    end
  end
end
