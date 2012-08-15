class Bankaccount < ActiveRecord::Base
  attr_accessible :account_number, :balance, :user_id, :account_name, :bankstatement
  after_create :add_amount
  belongs_to :user
  default_scope order: 'bankaccounts.created_at DESC'
  

  
  validates :account_number, :numericality => true
  
  def account_balance
    self.account_number.to_s + ' Bal: ' + self.balance.to_s
  end
  
  def add_amount
    self.balance = rand(1000) + (1/rand(1..10).to_f * 100).to_i / 100.to_f
    self.save
  end
end
