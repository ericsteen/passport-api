require 'rails_helper'

RSpec.describe "Boats", type: :request do

  describe "GET /boats" do
    it "sends a list of boats" do
      FactoryGirl.create_list(:boat, 1)

      get boats_path
      json = JSON.parse(response.body)

      boat = json.first.with_indifferent_access

      expect(boat[:name]).to eq("Amazon Express")
      expect(boat[:capacity]).to eq(8)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /boats" do
    it "stores a new boat" do
      post boats_path, params: { boat: { capacity: 8, duration: 120 } }

      expect(response).to have_http_status(201)
    end
  end
end
