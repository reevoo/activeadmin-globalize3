ActiveAdmin.setup do |config|

  config.site_title = "Test Admin"

  #Don't use any auth
  config.authentication_method = false
  config.current_user_method = false


  config.allow_comments = false
  config.batch_actions = true
end
