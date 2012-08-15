class TransfersController < ApplicationController
   before_filter :signed_in_user
   
   
  def index
    @user = current_user
    @transfers = current_user.transfers
  end
  
  def new
    
  end
  
  def create
    
  end
  
  
end
