class RemoveClosingDateAndInvoiceDateFromCards < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :closing_date, :date
    remove_column :cards, :invoice_date, :date
  end
end
