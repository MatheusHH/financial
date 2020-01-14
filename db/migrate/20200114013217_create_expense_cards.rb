class CreateExpenseCards < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_cards do |t|
      t.date :invoice_date
      t.monetize :value
      t.integer :status
      t.references :card, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
