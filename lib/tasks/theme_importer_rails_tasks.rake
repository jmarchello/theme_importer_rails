namespace :theme_importer do

  desc "Import a theme"
  task :import, :theme_origin do |t, args|
    ThemeImporterRails.import_theme(args.theme_origin)
  end

  desc "Clean out imported theme"
  task :clean do
    ThemeImporterRails.clean
  end

end