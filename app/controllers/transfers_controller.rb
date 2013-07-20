class TransfersController < ApplicationController
   before_filter :signed_in_user
   
   
  def index
    @user = current_user
    @transfers = current_user.transfers
    @transfers_to_me = Transfer.find_all_by_to_user_id(current_user)
    @new_transfer = Transfer.new
    @all_users = User.all
    @admin = @user.admin if true
    #@all_transfers = Transfer.paginate(page: params[:page])
    @all_transfers = Transfer.all
  end
  
  def new
   
    @amount = 0
    
  end
  
  def create
    #debug(params[:transfer])
    


    if (params[:transfer][:from].blank? || params[:transfer][:to_user_id].blank? || params[:transfer][:amount].blank?) 
      redirect_to transfers_path, :flash => {:error => "Please Fill in All Fields!"}
      #@res = params[:transfer][:to_user_id].blank?
      #raise @res.inspect 
    else
      @transfer = current_user.transfers.build(params[:transfer])
     
      if @transfer.amount  > Bankaccount.find_by_account_number(@transfer.from).balance
        redirect_to transfers_path, :flash => {:error => "Sorry you dont have enough money to make the transfer. The account #{@transfer.from} only has #{Bankaccount.find_by_account_number(@transfer.from).balance}"}
      else
        if @transfer.save
          redirect_to transfers_path, :flash => 
          { :success => "You Transferred Succesfully  $#{@transfer.amount} from  #{@transfer.from} to  #{User.find(@transfer.to_user_id).name}" }
        else
          redirect_to 'transfers_path', :flash => { :error => "Error on Transfer" }
        end
      end
    end
  
  end
end
