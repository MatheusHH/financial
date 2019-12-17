class AddAccountToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenses, :account, foreign_key: true
  end
end
