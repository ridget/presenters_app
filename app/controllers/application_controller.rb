class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  unless Rails.application.config.consider_all_requests_local
    rescue_from CanCan::AccessDenied do |exception|
      # Notify errbit if you would like to:
      # Airbrake.notify(exception)
      render 'public/403', status: 403, layout: 'none'
    end
  end

end
