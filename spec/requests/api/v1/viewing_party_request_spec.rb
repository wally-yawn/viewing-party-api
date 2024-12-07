require "rails_helper"

RSpec.describe "Viewing Party API" do
  describe "creating a viewing party" do
    before :each do
      @user1 = User.create!(name: "Wally", username: "www1", password: "abc123")
      @user2 = User.create!(name: "Wally2", username: "www2", password: "abc123")
      @viewing_party_body = {
        name: "Wally's Party!",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id, @user2.id]
      }
    end

    it 'creates a viewing party' do

      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_body, as: :json

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body, symbolize_names: true)
      # expect(json[:data][:type]).to eq("user")
      # expect(json[:data][:id]).to eq(User.last.id.to_s)
      # expect(json[:data][:attributes][:name]).to eq(user_params[:name])
      # expect(json[:data][:attributes][:username]).to eq(user_params[:username])
      # expect(json[:data][:attributes]).to have_key(:api_key)
      # expect(json[:data][:attributes]).to_not have_key(:password)
      # expect(json[:data][:attributes]).to_not have_key(:password_confirmation)
    end
  end
end