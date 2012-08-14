class HomeController < ApplicationController
  
  def index
    @title = 'Home'
  end

  def about 
    @title = 'About'
  end

  def help
    @title = 'Help'
  end

end
