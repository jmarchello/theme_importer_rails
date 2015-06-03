require "test_helper"

class FileEditorTest < ActiveSupport::TestCase
  def setup
    @file_sorter = FileSorter.new('test/theme')
    @file_sorter.find_css
    @file_sorter.move_css_files
    @file_editor = FileEditor.new
  end

  def teardown
    FileUtils.rm_rf("#{Rails.root}/vendor/assets/imported_theme") if Dir.exist?("#{Rails.root}/vendor/assets/imported_theme")
  end

  def test_edit_urls_in_css_file
    file = "#{Rails.root}/vendor/assets/imported_theme/stylesheets/bootstrap.css"
    @file_editor.edit_urls_in_css_file(file)
    assert(diff(file, 'test/edited_bootstrap.css'))
  end
end
