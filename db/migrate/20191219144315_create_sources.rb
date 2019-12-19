class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string :name
      t.string :phone
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
