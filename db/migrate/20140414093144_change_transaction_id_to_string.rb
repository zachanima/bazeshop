class ChangeTransactionIdToString < ActiveRecord::Migration
  def change
    change_column :orders, :transaction_id, :string
  end
end
