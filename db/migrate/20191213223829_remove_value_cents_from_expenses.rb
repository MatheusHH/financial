class RemoveValueCentsFromExpenses < ActiveRecord::Migration[5.2]
  def change
    remove_column :expenses, :value_cents, :integer
  end
end
