class AddTextToOptionSets < ActiveRecord::Migration
  def change
    add_column :option_sets, :text, :string
  end
end
