class AddPlaintextPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :plaintext_password, :string
  end
end
