class AddFieldsToShops < ActiveRecord::Migration
  def change
    add_column :shops, :login_text, :string
    add_column :shops, :password_text, :string
    add_column :shops, :text, :text
    add_column :shops, :currency, :string
    add_column :shops, :border_style, :string
    add_column :shops, :link_style, :string
    add_column :shops, :custom_style, :string
    add_column :shops, :receipt_text, :text
    add_column :shops, :correspondent, :string
    add_column :shops, :shipping_price, :float
    add_column :shops, :free_shipping_over, :float
  end
end
