class AddAllowPaymentToShops < ActiveRecord::Migration
  def change
    add_column :shops, :allow_payment, :boolean
  end
end
