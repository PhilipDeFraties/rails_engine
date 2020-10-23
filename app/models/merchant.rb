class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :transactions
  has_many :invoice_items

  def self.import_merchants
    merchants = []
    CSV.foreach('db/seeds/merchants.csv', headers: true) do |row|
      merchants << row.to_h
    end
    Merchant.import(merchants)
  end

  def self.by_revenue(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, merchants.name, SUM(invoice_items.unit_price * invoice_items.quantity) AS total")
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .group("merchants.id")
    .order("total DESC")
    .limit(quantity)
  end
end
