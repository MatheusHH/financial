class CreateKinds < ActiveRecord::Migration[5.2]
  def change
    create_table :kinds do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
