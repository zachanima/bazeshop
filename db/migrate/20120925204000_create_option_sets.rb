class CreateOptionSets < ActiveRecord::Migration
  def change
    create_table :option_sets do |t|
      t.string :name
      t.boolean :optional
      t.integer :position

      t.timestamps
    end
  end
end
