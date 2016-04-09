class ApiController < ApplicationController

  def current_user
    @user ||= User.find_by(email: "james@foggy.io")
  end
end
