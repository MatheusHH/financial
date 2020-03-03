class AddTimesToExpenseCards < ActiveRecord::Migration[5.2]
  def change
    add_column :expense_cards, :times, :integer, default: 0
  end
end
