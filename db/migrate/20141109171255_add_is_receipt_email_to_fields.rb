class AddIsReceiptEmailToFields < ActiveRecord::Migration
  def change
    add_column :fields, :is_receipt_email, :boolean
  end
end
