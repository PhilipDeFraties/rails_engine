class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.float :unit_price


      t.references :merchant, foreign_key: true
    end
  end
end
