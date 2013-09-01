class CreateFields < ActiveRecord::Migration
  def change
    create_table :fields do |t|
      t.string :text
      t.boolean :required
      t.references :shop

      t.timestamps
    end
  end
end
