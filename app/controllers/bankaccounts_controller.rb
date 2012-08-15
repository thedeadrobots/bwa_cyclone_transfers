class BankaccountsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  
  def create
    @bankaccount = current_user.bankaccounts.build(params[:bankaccount])
    if @bankaccount.save
      flash[:success] = "Bank Account Added & Balance Downloaded"
      redirect_to current_user
    else
      flash[:error] = "Bank Account Cannot Be Added. Are you sure your account number is numeric only?"
      redirect_to current_user
    end
  end
  
  def destroy
    @bankaccount = current_user.bankaccounts.find_by_id(params[:id])
    @bankaccount.destroy
    flash[:success] = "Bank Account Deleted"
    redirect_to current_user  
  end
  

      
end
