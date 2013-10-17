class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.string :name
      t.string :ip
      t.string :hack_type

      t.timestamps
    end
  end
end
