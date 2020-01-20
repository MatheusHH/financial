class CreatePaymentCards < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_cards do |t|
      t.date :invoice_payment_date
      t.monetize :value
      t.references :card, foreign_key: true
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
