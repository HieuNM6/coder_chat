OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '507094529472741', '8a53bee4b0d47609e195e1712ab0da33'
end
