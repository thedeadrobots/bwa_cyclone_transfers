class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :to
      t.integer :from
      t.float :amount
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
