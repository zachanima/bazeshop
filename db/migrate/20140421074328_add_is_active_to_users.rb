class AddIsActiveToUsers < ActiveRecord::Migration
  def up
    add_column :users, :is_active, :boolean
    User.all.each do |user|
      user.is_active = true
      user.save
    end
  end

  def down
    remove_column :users, :is_active
  end
end
