class AddToUserIdToTransfers < ActiveRecord::Migration
  def change
    add_column :transfers, :to_user_id, :integer
  end
end
