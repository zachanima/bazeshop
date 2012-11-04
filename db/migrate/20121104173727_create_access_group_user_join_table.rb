class CreateAccessGroupUserJoinTable < ActiveRecord::Migration
  def change
    create_table :access_groups_users, id: false do |t|
      t.references :access_group
      t.references :user
    end
  end
end
