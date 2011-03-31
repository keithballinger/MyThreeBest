FacebookConfig = YAML.load_file(File.join(Rails.root, 'config', 'facebook.yml'))[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FacebookConfig['app_id'], FacebookConfig['app_secret'], { :scope => FacebookConfig['app_scope'] }
end

