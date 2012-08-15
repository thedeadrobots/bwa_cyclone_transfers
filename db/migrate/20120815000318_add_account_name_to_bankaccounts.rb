class AddAccountNameToBankaccounts < ActiveRecord::Migration
  def change
    add_column :bankaccounts, :account_name, :string
  end
end
