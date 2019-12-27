class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.integer :sender_account
      t.integer :receiver_account
      t.monetize :value
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
