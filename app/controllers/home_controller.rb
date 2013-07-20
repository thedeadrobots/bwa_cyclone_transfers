require 'socket'
class HomeController < ApplicationController
  
  def index
    @title = 'Home'
    @user = current_user
    @ip = local_ip
    if current_user
      @admin = current_user.admin ? 'true' : 'false'
    end

  end

  def about 
    @title = 'About'
   
  end

  def help
    @title = 'Help'
     @ip = local_ip
  end

end
