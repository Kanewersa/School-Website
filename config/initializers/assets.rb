# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( application.js )
Rails.application.config.assets.precompile += %w( requestable-preview.js )
Rails.application.config.assets.precompile += %w( devise.css )
Rails.application.config.assets.precompile += %w( dashboard.scss )
Rails.application.config.assets.precompile += %w( test.css )
Rails.application.config.assets.precompile += %w( custom/bootstrap-datepicker3.standalone.min.css )
# Precompile all fonts
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf|otf|woff2)\z/