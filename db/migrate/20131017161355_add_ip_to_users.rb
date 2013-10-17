class AddIpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ip_address, :string
  end
end
