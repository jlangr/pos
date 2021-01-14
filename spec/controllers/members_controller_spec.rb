RSpec.describe "members API", type: :request do
  let!(:members) { create_list(:member, 5) }
  let(:member_id) { members.first.id }

  describe "GET /members/:id" do
    before { get "/members/#{member_id}" }

    context "when the member exists" do
      it "returns the member" do
        expect(json["id"]).to eq(member_id)
      end

      it "returns status 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the member does not exist" do
      let(:member_id) { 9999 }
      it "returns not found error" do
        expect(response).to have_http_status(404)
        expect(response.body).to match(/Couldn't find Member/)
      end
    end
  end

  describe "POST /members" do
    let(:valid_attributes) { { name: "Joha Djo", phone: "+41 313-33-344", discount: 0.01 } }

    context "when the request is valid" do
      before { post "/members", params: valid_attributes }

      it 'creates a member' do
        expect(json["name"]).to eq("Joha Djo")
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end
  end
end
