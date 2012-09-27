class Admin::ApplicationController < ApplicationController
  before_filter :authenticate!
  layout 'admin'

  def authenticate!
    authenticate_or_request_with_http_basic do |login, password|
      login == 'login' && password == 'password'
    end
  end
end
