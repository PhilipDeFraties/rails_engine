require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    expect(merchants).to have_key(:data)
    expect(merchants[:data]).to be_an(Array)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant).to have_key(:relationships)
      expect(merchant[:relationships]).to be_a(Hash)

      expect(merchant[:relationships]).to have_key(:items)
      expect(merchant[:relationships][:items]).to be_a(Hash)

      expect(merchant[:relationships][:items]).to have_key(:data)
      expect(merchant[:relationships][:items][:data]).to be_an(Array)
    end
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant).to have_key(:data)
    expect(merchant[:data]).to be_a(Hash)

    expect(merchant[:data]).to have_key(:id)
    expect(merchant[:data][:id]).to be_a(String)

    expect(merchant[:data]).to have_key(:attributes)
    expect(merchant[:data][:attributes]).to be_a(Hash)

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)

    expect(merchant[:data]).to have_key(:relationships)
    expect(merchant[:data][:relationships]).to be_a(Hash)

    expect(merchant[:data][:relationships]).to have_key(:items)
    expect(merchant[:data][:relationships][:items]).to be_a(Hash)

    expect(merchant[:data][:relationships][:items]).to have_key(:data)
    expect(merchant[:data][:relationships][:items][:data]).to be_an(Array)
  end

  it "can create a new merchant" do
    merchant_id = create(:merchant).id
    merchant_params = ({  name: 'Globodyne' })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant_params)

    created_merchant = Merchant.last

    expect(response).to be_successful
    expect(created_merchant.name).to eq(merchant_params[:name])
  end

  it "can delete an merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can update an merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "Globodyne" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate(merchant_params)
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Globodyne")
  end

  it "can get items for a merchant" do
    merchant = create(:merchant)
    10.times do
      create(:item, merchant_id: merchant.id)
    end

    get "/api/v1/merchants/#{merchant.id}/items"

    merchant_items = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant_items).to have_key(:data)
    expect(merchant_items[:data]).to be_an(Array)
    expect(merchant_items[:data].count).to eq(10)

    merchant_items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)

      expect(item).to have_key(:relationships)
      expect(item[:relationships]).to be_a(Hash)

      expect(item[:relationships]).to have_key(:merchant)
      expect(item[:relationships][:merchant]).to be_a(Hash)

      expect(item[:relationships][:merchant]).to have_key(:data)
      expect(item[:relationships][:merchant][:data]).to be_a(Hash)

      expect(item[:relationships][:merchant][:data]).to have_key(:id)
      expect(item[:relationships][:merchant][:data][:id]).to be_a(String)
    end
  end
end
