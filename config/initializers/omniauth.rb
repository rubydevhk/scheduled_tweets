Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.credentials.dig(:twitter, :api_key), Rails.application.credentials.dig(:twitter, :api_secret)
end

# TODO [SECURITY-MED]: allowing :get here re-opens the login-CSRF hole that
# OmniAuth 2.x closed by defaulting to POST-only. An attacker can embed
# <img src="/auth/twitter"> on a third-party page to force a logged-in
# victim into an auth flow they didn't initiate. Prefer switching the
# sign-in link to `button_to` (POST) + the `omniauth-rails_csrf_protection`
# gem instead of this, once the view is wired up.
OmniAuth.config.allowed_request_methods = %i[get post]
