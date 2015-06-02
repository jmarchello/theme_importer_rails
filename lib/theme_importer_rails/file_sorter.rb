require "FileUtils"

class FileSorter
  private

  @theme_orig
  @css_files
  @js_files

  public

  def initialize(theme_orig)
    @theme_orig = theme_orig
  end

  def find_css
    @css_files = Dir.glob("#{@theme_orig}/**/*{.css,.scss}")
  end

  def find_js
    @js_files = Dir.glob("#{@theme_orig}/**/*{.js,.coffee}")
  end

  def move_css_files
    if !Dir.exist?("vender/assets")
      Dir.mkdir("vender/assets")
    end

    if !Dir.exist?("vender/assets/stylesheets")
      Dir.mkdir("vender/assets/stylesheets")
    end

    @css_files.each do |file|
      file_name = File.basename(file)
      FileUtils.cp(file, "vender/assets/stylesheets/#{file_name}")
    end
  end
end
