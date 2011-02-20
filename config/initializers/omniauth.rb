fb_config = YAML.load_file(File.join(Rails.root, 'config', 'facebook.yml'))[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, fb_config['app_id'], fb_config['app_secret'], { :scope => fb_config['app_scope'] }
end

