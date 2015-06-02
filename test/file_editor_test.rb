require "test_helper"

class FileEditorTest < ActiveSupport::TestCase
  def setup
    file_sorter = FileSorter.new("test/theme")
    file_sorter.find_css
    file_sorter.move_css_files
  end

  def teardown
    if Dir.exist?("#{Rails.root}/vender/assets/imported_theme")
      FileUtils.rm_rf("#{Rails.root}/vender/assets/imported_theme")
    end
  end
end
