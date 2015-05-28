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
end
