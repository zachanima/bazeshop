class Admin::ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate!
  layout 'admin'

  def authenticate!
    authenticate_or_request_with_http_basic do |login, password|
      login == 'login' && password == 'password'
    end
  end
end
