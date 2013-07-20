class Transfer < ActiveRecord::Base
  attr_accessible :amount, :from, :status, :to, :user_id, :to_user_id
  belongs_to :user
  
  before_save :pick_account

  validates :amount, :numericality => true
  validates :to_user_id, :presence => true
  validates :from, :presence => true
  
  default_scope order: 'transfers.created_at DESC'
  after_save :update_balance
  
  def pick_account
    to_user = User.find(self.to_user_id)
    self.to = to_user.bankaccounts.first.account_number
  end
  
  def update_balance
    from_user = User.find(self.user_id)
    to_user = User.find(self.to_user_id)
    from_account = from_user.bankaccounts.find_by_account_number(self.from)
    to_account = to_user.bankaccounts.find_by_account_number(self.to)
    starting_from_balance = from_account.balance 
    starting_to_balance = to_account.balance
    new_from_balance = starting_from_balance - amount
    new_to_balance = starting_to_balance + amount
    
    from_account.update_attributes(:balance => new_from_balance)
    to_account.update_attributes(:balance => new_to_balance)
  end
    
end
