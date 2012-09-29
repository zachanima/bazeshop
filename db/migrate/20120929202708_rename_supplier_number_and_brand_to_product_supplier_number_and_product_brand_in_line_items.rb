class RenameSupplierNumberAndBrandToProductSupplierNumberAndProductBrandInLineItems < ActiveRecord::Migration
  def up
    rename_column :line_items, :supplier_number, :product_supplier_number
    rename_column :line_items, :brand, :product_brand
  end

  def down
    rename_column :line_items, :product_supplier_number, :supplier_number
    rename_column :line_items, :product_brand, :brand
  end
end
