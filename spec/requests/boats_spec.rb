require 'rails_helper'

RSpec.describe "Boats", type: :request do
  describe "GET /boats" do
    it "works! (now write some real specs)" do
      get boats_path
      expect(response).to have_http_status(200)
    end
  end
end
