require "rails_helper"

RSpec.describe 'checkouts API', type: :request do

  describe "checkouts" do
    before { post "/checkouts", params: {} }
    let(:checkout_id) { json["id"] }

    describe "successful checkout creation" do
      it "has success status" do
        expect(response).to have_http_status(201)
      end
    end

    describe "retrieving the checkout" do
      before { get "/checkouts/#{checkout_id}" }

      it "returns the checkout" do
        expect(json["id"]).to eq(checkout_id)
      end

      it "returns status 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "when requesting a nonexistent checkout" do
    it "returns not found error" do
      get "/checkouts/99999"

      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Checkout/)
    end
  end

end
