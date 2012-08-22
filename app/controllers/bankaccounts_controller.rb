class BankaccountsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]

  
  def create
    
    uploaded_io = params[:bankaccount][:bankstatement]
    if uploaded_io
      filename = "bankstatement-" + current_user.id.to_s + rand(1..10).to_s+".pdf"
      File.open(Rails.root.join('public', 'uploads', filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end
    params[:bankaccount][:bankstatement] = filename

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
  
  def upload
    file = params[:bankaccount][:bankstatement]
    File.open(Rails.root.join('public', 'uploads', file.original_filename), 'wb') do |f|
      f.write(file.read)
    end
  end

      
end
