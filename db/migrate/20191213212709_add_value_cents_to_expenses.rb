class AddValueCentsToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_column :expenses, :value_cents, :integer
  end
end
