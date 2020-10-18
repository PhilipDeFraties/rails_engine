require 'csv'
require 'activerecord-import'
class Item < ApplicationRecord
  belongs_to :merchant

  def self.import_items
    items = []
    CSV.foreach('db/seeds/items.csv', headers: true) do |row|
      items << row.to_h
    end
    Item.import(items)
  end
end
