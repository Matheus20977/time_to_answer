# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w(admin.js admin.css admins_backoffice.js admins_backoffice.scss users_backoffice.js users_backoffice.scss admin_devise.js admin_devise.scss bootstrap.min.js popper.js jquery.js sb-admin-2.js jquery.easing.js site.scss site.js)
