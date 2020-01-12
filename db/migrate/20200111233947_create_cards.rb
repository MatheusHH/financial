class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.date :closing_date
      t.date :invoice_date
      t.monetize :limit_value
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
