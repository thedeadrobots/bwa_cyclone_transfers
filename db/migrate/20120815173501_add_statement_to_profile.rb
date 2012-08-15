class AddStatementToProfile < ActiveRecord::Migration
  def change
    add_column :users, :profile_statement, :string
  end
end
