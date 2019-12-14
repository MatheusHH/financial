class RemoveValueFromExpenses < ActiveRecord::Migration[5.2]
  def change
    remove_column :expenses, :value, :integer
  end
end
