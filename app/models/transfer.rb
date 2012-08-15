class Transfer < ActiveRecord::Base
  attr_accessible :amount, :from, :status, :to, :user_id, :to_user_id
  belongs_to :user
end
