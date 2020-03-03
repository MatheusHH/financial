class RemoveTimesFromExpenseCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :expense_cards, :times, :integer
  end
end
