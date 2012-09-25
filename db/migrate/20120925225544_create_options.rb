class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name
      t.integer :position
      t.references :option_group

      t.timestamps
    end
    add_index :options, :option_group_id
  end
end
