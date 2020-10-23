require 'rails_helper'

describe 'Merchant Item' do
  it 'can fetch the merchant for an item' do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(merchant[:type]).to eq('merchant')
  end

end
