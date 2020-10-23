require 'rails_helper'

describe 'Item Merchant' do
  it 'can fetch all items for a merchant' do
    merchant = create(:merchant)
    create_list(:item, 5, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.count).to eq(5)

    items.each do |item|
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

  it "fetches items pertaining only to its merchant" do
    walmart = create(:merchant)
    create_list(:item, 3, merchant: walmart)

    target = create(:merchant)
    create_list(:item, 3, merchant: target)

    kmart = create(:merchant)
    create_list(:item, 3, merchant: kmart)

    get "/api/v1/merchants/#{target.id}/items"
    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(items.length).to eq(3)
  end

end
