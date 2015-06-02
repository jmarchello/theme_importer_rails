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

  def create_imported_theme_dir
    if !Dir.exist?("#{Rails.root}/vender/assets")
      Dir.mkdir("#{Rails.root}/vender/assets")
    end

    if !Dir.exist?("#{Rails.root}/vender/assets/imported_theme")
      Dir.mkdir("#{Rails.root}/vender/assets/imported_theme")
    end
  end

  def move_css_files
    create_imported_theme_dir

    if !Dir.exist?("#{Rails.root}/vender/assets/imported_theme/stylesheets")
      Dir.mkdir("#{Rails.root}/vender/assets/imported_theme/stylesheets")
    end

    @css_files.each do |file|
      file_name = File.basename(file)
      FileUtils.cp(file, "#{Rails.root}/vender/assets/imported_theme/stylesheets/#{file_name}")
    end
  end

  def move_js_files
    create_imported_theme_dir

    if !Dir.exist?("#{Rails.root}/vender/assets/imported_theme/javascripts")
      Dir.mkdir("#{Rails.root}/vender/assets/imported_theme/javascripts")
    end

    @js_files.each do |file|
      file_name = File.basename(file)
      FileUtils.cp(file, "#{Rails.root}/vender/assets/imported_theme/javascripts/#{file_name}")
    end
  end

  def generate_css_manifest
    create_imported_theme_dir

    manifest_file = File.open("#{Rails.root}/vender/assets/imported_theme/imported_theme.css", "w")
    manifest_file.puts("/*")
    @css_files.each do |css_file|
      css_file_name = File.basename(css_file)
      manifest_file.puts("*= require stylesheets/#{css_file_name}")
    end
    manifest_file.puts("*/")
    manifest_file.close
  end

  def generate_js_manifest
    create_imported_theme_dir

    manifest_file = File.open("#{Rails.root}/vender/assets/imported_theme/imported_theme.js", "w")
    @js_files.each do |js_file|
      js_file_name = File.basename(js_file)
      manifest_file.puts("//= require javascripts/#{js_file_name}")
    end
    manifest_file.close
  end

end
