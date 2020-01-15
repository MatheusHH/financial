class AddClosingDayAndInvoiceDayToCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :closing_day, :integer
    add_column :cards, :invoice_day, :integer
  end
end
