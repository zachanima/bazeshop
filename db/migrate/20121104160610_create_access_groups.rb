class CreateAccessGroups < ActiveRecord::Migration
  def change
    create_table :access_groups do |t|
      t.string :name
      t.references :shop

      t.timestamps
    end
  end
end
