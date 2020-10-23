# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# csv_files = ['db/seeds/merchants.csv', 'db/seeds/items.csv']
#
# def import_items
#   items = []
#   CSV.foreach('db/seeds/items.csv', headers: true) do |row|
#     row["unit_price"] = convert_price(row["unit_price"])
#     items << row.to_h
#   end
#   Item.import(items)
# end
#
# def convert_price(price)
#   (price.to_i * 0.01).round(2)
# end
Customer.import_customers
Merchant.import_merchants
Item.import_items
Invoice.import_invoices
InvoiceItem.import_invoice_items
Transaction.import_transactions
