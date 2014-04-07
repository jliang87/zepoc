OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '291436424347018', '7563c879226ef4f5558aecb832940e4f'
end