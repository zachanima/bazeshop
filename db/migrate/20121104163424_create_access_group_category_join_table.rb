class CreateAccessGroupCategoryJoinTable < ActiveRecord::Migration
  def change
    create_table :access_groups_categories, id: false do |t|
      t.references :access_group
      t.references :category
    end
  end
end
