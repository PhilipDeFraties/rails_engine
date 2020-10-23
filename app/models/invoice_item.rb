class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  def self.import_invoice_items
    invoice_items = []
    CSV.foreach('db/seeds/invoice_items.csv', headers: true) do |row|
      row["unit_price"] = convert_price(row["unit_price"])
      invoice_items << row.to_h
    end
    InvoiceItem.import(invoice_items)
  end

  def self.convert_price(price)
    (price.to_i * 0.01).round(2)
  end
end
