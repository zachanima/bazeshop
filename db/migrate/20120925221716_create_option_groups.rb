class CreateOptionGroups < ActiveRecord::Migration
  def change
    create_table :option_groups do |t|
      t.string :name
      t.integer :position
      t.references :option_set

      t.timestamps
    end
  end
end
