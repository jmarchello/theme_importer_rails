require "minitest/autorun"

class TestFileEditor < Minitest::Test
  def setup
    @filename = "test/files/test.css"
  end

  def test_reading_file
    file_txt = ""
    IO.foreach(@filename) do |line|
      file_txt << line
    end

    expected_txt = "@font-face {
  font-family: 'Glyphicons Halflings';
  src: url('../fonts/glyphicons-halflings-regular.eot');
  src: url('../fonts/glyphicons-halflings-regular.eot?#iefix') format('embedded-opentype'), url('../fonts/glyphicons-halflings-regular.woff2') format('woff2'), url('../fonts/glyphicons-halflings-regular.woff') format('woff'), url('../fonts/glyphicons-halflings-regular.ttf') format('truetype'), url('../fonts/glyphicons-halflings-regular.svg#glyphicons_halflingsregular') format('svg');
}"

    assert_equal(expected_txt, file_txt)
  end
end
