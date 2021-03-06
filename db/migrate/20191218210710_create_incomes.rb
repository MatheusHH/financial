class CreateIncomes < ActiveRecord::Migration[5.2]
  def change
    create_table :incomes do |t|
      t.date :receipt_date
      t.monetize :value
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
