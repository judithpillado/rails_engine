require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq('item')

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)

      expect(item[:attributes]).to have_key(:merchant_id)
      expect(item[:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)

    expect(item).to have_key(:type)
    expect(item[:type]).to eq('item')

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = ({
                    name: 'Foundation Brush',
                    description: 'Excellent soft brush for delicate skin.',
                    unit_price: 19.99,
                    merchant_id: merchant.id
    })
    post '/api/v1/items', params: item_params
    expect(response).to be_successful
    item = Item.last

    new_item = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(new_item[:attributes][:name]).to eq(item.name)
    expect(new_item[:attributes][:description]).to eq(item.description)
    expect(new_item[:attributes][:unit_price]).to eq(item.unit_price)
    expect(new_item[:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    previous_description = Item.last.description
    previous_unit_price = Item.last.unit_price
    item_params = { name: "Thingamabob",
                    description: "Used for anything and everything!",
                    unit_price: 30.00
    }

    patch "/api/v1/items/#{id}", params: item_params
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Thingamabob")

    expect(item.description).to_not eq(previous_description)
    expect(item.description).to eq("Used for anything and everything!")

    expect(item.unit_price).to_not eq(previous_unit_price)
    expect(item.unit_price).to eq(30.00)
  end

  it "can destroy a item" do
    item = create(:item)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
