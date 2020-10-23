class Customer < ApplicationRecord
  has_many :invoices
  def self.import_customers
    customers = []
    CSV.foreach('db/seeds/customers.csv', headers: true) do |row|
      customers << row.to_h
    end
    Customer.import(customers)
  end
end
