# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '2.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w(leader_board.js points.js)
Rails.application.config.assets.precompile += %w(admin.css admin-score.css ie.css bonus_logger.css)

