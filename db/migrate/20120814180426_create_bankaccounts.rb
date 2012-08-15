class CreateBankaccounts < ActiveRecord::Migration
  def change
    create_table :bankaccounts do |t|
      t.integer :account_number
      t.float :balance
      t.integer :user_id

      t.timestamps
    end
  end
end
