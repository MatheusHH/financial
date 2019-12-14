class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.date :duedate
      t.references :category, foreign_key: true
      t.references :supplier, foreign_key: true
      t.integer :status
      t.integer :value
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
