class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant

  def self.import_invoices
    invoices = []
    CSV.foreach('db/seeds/invoices.csv', headers: true) do |row|
      invoices << row.to_h
    end
    Invoice.import(invoices)
  end
end
