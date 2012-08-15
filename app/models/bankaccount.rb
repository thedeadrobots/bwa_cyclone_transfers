class Bankaccount < ActiveRecord::Base
  attr_accessible :account_number, :balance, :user_id, :account_name
  after_create :add_amount
  belongs_to :user
  
  validates :account_number, :numericality => true
  
  def add_amount
    self.balance = rand(1000) + (1/rand(1..10).to_f * 100).to_i / 100.to_f
    self.save
  end
end
