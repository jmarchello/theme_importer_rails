require "FileUtils"

class FileSorter
  private

  @theme_orig
  @css_files
  @js_files
  @font_files
  @images

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

  def find_font_files
    @font_files = Dir.glob("#{@theme_orig}/**/*{#{FONT_EXTENSIONS.join(',')}}")
  end

  def find_images
    @images = Dir.glob("#{@theme_orig}/**/*{#{IMAGE_EXTENSIONS.join(',')}}")
  end

  def create_imported_theme_dir
    # vendor assets directory for css and js files
    unless Dir.exist?("#{Rails.root}/vendor/assets")
      Dir.mkdir("#{Rails.root}/vendor/assets")
    end

    unless Dir.exist?("#{Rails.root}/vendor/assets/imported_theme")
      Dir.mkdir("#{Rails.root}/vendor/assets/imported_theme")
    end

    #public assets directory for fonts and images
    unless Dir.exist?("#{Rails.root}/public/assets")
      Dir.mkdir("#{Rails.root}/public/assets")
    end

    unless Dir.exist?("#{Rails.root}/public/assets/imported_theme")
      Dir.mkdir("#{Rails.root}/public/assets/imported_theme")
    end
  end

  def move_css_files
    unless @css_files.nil?
      create_imported_theme_dir

      unless Dir.exist?("#{Rails.root}/vendor/assets/imported_theme/stylesheets")
        Dir.mkdir("#{Rails.root}/vendor/assets/imported_theme/stylesheets")
      end

      @css_files.each do |file|
        file_name = File.basename(file)
        FileUtils.cp(file, "#{Rails.root}/vendor/assets/imported_theme/stylesheets/#{file_name}")
      end
    end
  end

  def move_js_files
    unless @js_files.nil?
      create_imported_theme_dir

      unless Dir.exist?("#{Rails.root}/vendor/assets/imported_theme/javascripts")
        Dir.mkdir("#{Rails.root}/vendor/assets/imported_theme/javascripts")
      end

      @js_files.each do |file|
        file_name = File.basename(file)
        FileUtils.cp(file, "#{Rails.root}/vendor/assets/imported_theme/javascripts/#{file_name}")
      end
    end
  end

  def move_font_files
    unless @font_files.nil?
      create_imported_theme_dir

      unless Dir.exist?("#{Rails.root}/public/assets/imported_theme/fonts")
        Dir.mkdir("#{Rails.root}/public/assets/imported_theme/fonts")
      end

      @font_files.each do |file|
        file_name = File.basename(file)
        FileUtils.cp(file, "#{Rails.root}/public/assets/imported_theme/fonts/#{file_name}")
      end
    end
  end

  def move_images
    unless @images.nil?
      create_imported_theme_dir

      unless Dir.exist?("#{Rails.root}/public/assets/imported_theme/images")
        Dir.mkdir("#{Rails.root}/public/assets/imported_theme/images")
      end

      @images.each do |file|
        file_name = File.basename(file)
        FileUtils.cp(file, "#{Rails.root}/public/assets/imported_theme/images/#{file_name}")
      end
    end
  end

  def generate_css_manifest
    unless @css_files.nil?
      create_imported_theme_dir

      manifest_file = File.open("#{Rails.root}/vendor/assets/imported_theme/imported_theme.css", "w")
      manifest_file.puts("/*")
      @css_files.each do |css_file|
        css_file_name = File.basename(css_file)
        manifest_file.puts("*= require stylesheets/#{css_file_name}")
      end
      manifest_file.puts("*/")
      manifest_file.close
    end
  end

  def generate_js_manifest
    unless @js_files.nil?
      create_imported_theme_dir

      manifest_file = File.open("#{Rails.root}/vendor/assets/imported_theme/imported_theme.js", "w")
      @js_files.each do |js_file|
        js_file_name = File.basename(js_file)
        manifest_file.puts("//= require javascripts/#{js_file_name}")
      end
      manifest_file.close
    end
  end

end
