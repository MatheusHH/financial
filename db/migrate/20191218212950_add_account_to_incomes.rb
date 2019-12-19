class AddAccountToIncomes < ActiveRecord::Migration[5.2]
  def change
    add_reference :incomes, :account, foreign_key: true
  end
end
