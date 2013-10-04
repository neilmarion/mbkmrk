FACEBOOK = YAML.load_file("#{::Rails.root}/config/facebook.yml")[::Rails.env]
REALTIME_VERIFY_TOKEN = YAML.load_file("#{::Rails.root}/config/facebook_realtime_updates_verify_token.yml")[::Rails.env]
