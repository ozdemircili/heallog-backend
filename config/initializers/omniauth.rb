Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV.fetch("FACEBOOK_KEY"), ENV.fetch("FACEBOOK_SECRET"), scope: 'public_profile email'
  
  on_failure { |env| OmniauthCallbacksController.action(:failure).call(env) }
end
