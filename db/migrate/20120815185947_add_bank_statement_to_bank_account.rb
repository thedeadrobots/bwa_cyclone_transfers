class AddBankStatementToBankAccount < ActiveRecord::Migration
  def change
    add_column :bankaccounts, :bankstatement, :string
  end
end
