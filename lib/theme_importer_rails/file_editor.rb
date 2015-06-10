class FileEditor
  def edit_urls_in_css_file(file)
    pattern = /(?<=url\(('|"))(.*?)(?=('|")\))/
    temp = Tempfile.new("fonts2.css")
    File.open(file, "r+") do |f|
      f.each { |line| temp.puts line.gsub(pattern) { |match| "/assets/imported_theme/#{asset_type(match)}/#{match.to_s.split('/').last}"}}
    end
    temp.close
    FileUtils.mv(temp.path, file)
  end

  private

  def asset_type(file_name)
    file_extension = /(?<=\w)\.\D+?\d?(?=(#|\?|$))/.match(file_name.to_s)

    (FONT_EXTENSIONS.include? file_extension.to_s) ? 'fonts' : 'images'
  end
end
