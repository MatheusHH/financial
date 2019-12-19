class AddKindAndSourcesToIncomes < ActiveRecord::Migration[5.2]
  def change
    add_reference :incomes, :kind, foreign_key: true
    add_reference :incomes, :source, foreign_key: true
  end
end
