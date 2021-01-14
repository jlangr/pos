RSpec.describe "items API", type: :request do
  let!(:items) { create_list(:item, 5) }
  let(:item_id) { items.first.id }

  describe "GET /items" do
    before { get '/items' }

    it "returns all items" do
      expect(json.size).to eq(5)
    end

    it "returns status 200" do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /items/:id" do
    before { get "/items/#{item_id}" }

    context "when the item exists" do
      it "returns the item" do
        expect(json["id"]).to eq(item_id)
      end

      it "returns status 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the item does not exist" do
      let(:item_id) { 9999 }
      it "returns not found error" do
        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe "POST /items" do
    let(:valid_attributes) { { upc: "12345ABC", description: "milk", is_exempt: false, price: 2.25 } }

    context "when the request is valid" do
      before { post "/items", params: valid_attributes }

      it 'creates an item' do
        expect(json["description"]).to eq("milk")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the upc is not provided" do
      before { post "/items", params: { description: "milk", is_exempt: false, price: 2.25 } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(response.body)
          .to match(/Validation failed: Upc can't be blank/)
      end
    end
  end
end
