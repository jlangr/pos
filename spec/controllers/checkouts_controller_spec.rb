require "rails_helper"

RSpec.describe 'checkouts API', type: :request do

  describe "checkouts" do
    before { post "/checkouts", params: {} }
    let!(:checkout_id) { json["id"] }

    describe "successful checkout creation" do
      it "has success status" do
        expect(response).to have_http_status(201)
      end
    end

    describe "retrieving the checkout" do
      before { get "/checkouts/#{checkout_id}" }

      it "returns the checkout" do
        puts "response #{response.body}"
        expect(json["id"]).to eq(checkout_id)
      end

      it "returns status 200" do
        expect(response).to have_http_status(200)
      end
    end

    describe "scanning items" do
      before {
        post "/items/", params: { upc: "12345", description: "eggs", price: 2.25 }
        post "/checkouts/#{checkout_id}/scan/12345"
      }

      it "returns item with details" do
        expect(json["description"]).to eq("eggs")
        expect(json["price"]).to eq("2.25")
      end

      it "updates checkout with item" do
        get "/checkouts/#{checkout_id}"
        expect(json["items"].count).to eq(1)
        expect(json["items"][0]["upc"]).to eq("12345")
      end
    end

    describe "scanning a member" do
      before {
        post "/members", params: { name: "Ji Yang", phone: "719-287-4335", discount: "0.123" }
        get "/checkouts/#{checkout_id}" 
      }

      it "has no member initially" do
        expect(json["member_discount"]).to be_nil
      end

      context "when scanning a member" do
        before {
          post "/checkouts/#{checkout_id}/scan_member/719-287-4335"
          get "/checkouts/#{checkout_id}" 
        }

        it "has attached member information" do
          expect(json["member_discount"]).to eq("0.123")
        end
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
