require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    expect(items).to have_key(:data)
    expect(items[:data]).to be_an(Array)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_an(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item).to have_key(:data)
    expect(item[:data]).to be_a(Hash)

    expect(item[:data]).to have_key(:id)
    expect(item[:data][:id]).to be_a(String)

    expect(item[:data]).to have_key(:attributes)
    expect(item[:data][:attributes]).to be_a(Hash)

    expect(item[:data][:attributes]).to have_key(:name)
    expect(item[:data][:attributes][:name]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:description)
    expect(item[:data][:attributes][:description]).to be_a(String)

    expect(item[:data][:attributes]).to have_key(:unit_price)
    expect(item[:data][:attributes][:unit_price]).to be_an(Float)

    expect(item[:data][:attributes]).to have_key(:merchant_id)
    expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
  end

  it "can create a new item" do
    merchant_id = create(:merchant).id
    item_params = ({
                    name: 'Kick Pants',
                    description: 'Pants for kicking',
                    unit_price: 3000.00,
                    merchant_id: merchant_id
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item_params)

    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can delete an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can update an item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: "Kick Pants" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate(item_params)
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Kick Pants")
  end

  it "can get merchant for an item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchants"

    items_merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(items_merchant).to have_key(:data)
    expect(items_merchant[:data]).to be_an(Hash)

    expect(items_merchant[:data]).to have_key(:id)
    expect(items_merchant[:data][:id]).to be_a(String)
    expect(items_merchant[:data][:id].to_i).to eq(merchant.id)

    expect(items_merchant[:data]).to have_key(:attributes)
    expect(items_merchant[:data][:attributes]).to be_a(Hash)

    expect(items_merchant[:data][:attributes]).to have_key(:name)
    expect(items_merchant[:data][:attributes][:name]).to be_a(String)
    expect(items_merchant[:data][:attributes][:name]).to eq(merchant.name)

    expect(items_merchant[:data]).to have_key(:relationships)
    expect(items_merchant[:data][:relationships]).to be_a(Hash)

    expect(items_merchant[:data][:relationships]).to have_key(:items)
    expect(items_merchant[:data][:relationships][:items]).to be_a(Hash)

    expect(items_merchant[:data][:relationships][:items]).to have_key(:data)
    expect(items_merchant[:data][:relationships][:items][:data]).to be_an(Array)
    expect(items_merchant[:data][:relationships][:items][:data].count).to eq(1)

    expect(items_merchant[:data][:relationships][:items][:data][0]).to be_a(Hash)
    expect(items_merchant[:data][:relationships][:items][:data][0]).to have_key(:id)

    expect(items_merchant[:data][:relationships][:items][:data][0][:id]).to be_a(String)
    expect(items_merchant[:data][:relationships][:items][:data][0][:id]).to eq(item.id.to_s)
  end
end
