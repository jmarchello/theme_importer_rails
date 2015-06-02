
class FileEditor
  def edit_font_urls(file)
    pattern = /(?<=url\(('|"))(.*?)(?=('|")\))/
    temp = Tempfile.new("fonts2.css")
    File.open(file, "r+") do |file|
      file.each { |line| temp.puts line.gsub(pattern) { |match| "/assets/imported_theme/fonts/#{match.to_s.split('/').last}"}}
    end
    temp.close
    FileUtils.mv(temp.path, file)
  end
end
