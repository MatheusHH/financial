class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :agency_number
      t.string :account_number
      t.string :bank
      t.monetize :balance # Rails 4x and above
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
