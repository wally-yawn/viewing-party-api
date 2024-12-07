require "rails_helper"

RSpec.describe "Viewing Party API" do
  describe "creating a viewing party" do
    before :each do
      User.destroy_all
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
      # require 'pry'; binding.pry
      expect(json[:data][:type]).to eq("viewing_party")
      expect(json[:data][:id]).to eq(ViewingParty.last.id)
      expect(json[:data][:attributes][:name]).to eq(@viewing_party_body[:name])
      expect(json[:data][:attributes][:start_time]).to eq(@viewing_party_body[:start_time])
      expect(json[:data][:attributes][:end_time]).to eq(@viewing_party_body[:end_time])
      expect(json[:data][:attributes][:movie_id]).to eq(@viewing_party_body[:movie_id])
      expect(json[:data][:attributes][:movie_title]).to eq(@viewing_party_body[:movie_title])
      expect(json[:data][:attributes][:invitees][0][:id]).to eq(@user1.id)
      expect(json[:data][:attributes][:invitees][0][:name]).to eq(@user1.name)
      expect(json[:data][:attributes][:invitees][0][:username]).to eq(@user1.username)
      expect(json[:data][:attributes][:invitees][1][:id]).to eq(@user2.id)
      expect(json[:data][:attributes][:invitees][1][:name]).to eq(@user2.name)
      expect(json[:data][:attributes][:invitees][1][:username]).to eq(@user2.username)
    end

    #Need tests for
    #missing attributes
    #run time too long
    #end time before start time
    #invalid users (make the party just ignore the invalid user)
  end
end