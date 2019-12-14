class AddValueToExpenses < ActiveRecord::Migration[5.2]
  def change
    add_monetize :expenses, :value # Rails 4x and above
  end
end
