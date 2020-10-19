class Merchant < ApplicationRecord
  has_many :items

  def self.import_merchants
    merchants = []
    CSV.foreach('db/seeds/merchants.csv', headers: true) do |row|
      merchants << row.to_h
    end
    Merchant.import(merchants)
  end
end
