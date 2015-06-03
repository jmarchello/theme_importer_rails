
class FileEditor
  def edit_urls(file)
    pattern = /(?<=url\(('|"))(.*?)(?=('|")\))/
    temp = Tempfile.new("fonts2.css")
    File.open(file, "r+") do |f|
      f.each { |line| temp.puts line.gsub(pattern) { |match| "/assets/imported_theme/#{asset_type(match)}/#{match.to_s.split('/').last}"}}
    end
    temp.close
    FileUtils.mv(temp.path, file)
  end

  private

  def asset_type(match)
    FONT_EXTENSIONS.include? File.extname(match.to_s) ? 'fonts' : 'images'
  end
end
