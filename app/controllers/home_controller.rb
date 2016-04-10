class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:contact]

  def index
    @list = List.new
  end

  def contact
  end
end
