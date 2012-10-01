class ShopsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_shop
end
