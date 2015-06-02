class FileSorterTest < Minitest::Test
  def setup
    Dir.chdir("test/test_app")
    @vender_dir = "test_app/app/vender"
    @theme_orig = "test/theme/"
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

  def test_move_css_files
    file_sorter = FileSorter.new(@theme_orig)
    file_sorter.find_css
    css_files = file_sorter.instance_variable_get(:@css_files)
    file_sorter.move_css_files
    css_files.each do |file|
      filename = File.basename(file)
      assert(File.exists?("vender/assets/css/#{filename}"))
    end
  end
end
