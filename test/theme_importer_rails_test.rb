require 'test_helper'

class ThemeImporterRailsTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ThemeImporterRails
  end

  test "importing a theme" do
    ThemeImporterRails.import_theme('test/theme')

  end
end
