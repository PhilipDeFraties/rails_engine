class Transaction < ApplicationRecord
  belongs_to :invoice
  def self.import_transactions
    transactions = []
    CSV.foreach('db/seeds/transactions.csv', headers: true) do |row|
      transactions << row.to_h
    end
    Transaction.import(transactions)
  end
end
