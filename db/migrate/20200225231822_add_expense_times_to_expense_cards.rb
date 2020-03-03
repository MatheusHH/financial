class AddExpenseTimesToExpenseCards < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_cards, :expense_times, :integer
  end
end
