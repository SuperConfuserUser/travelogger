module SessionsHelper
  def facebook_auth_link
    link_to "Continue with Facebook", "/auth/facebook"
  end
end