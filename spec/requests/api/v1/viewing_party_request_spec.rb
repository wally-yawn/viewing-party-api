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
      json = JSON.parse(response.body, symbolize_names: true)
  
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body, symbolize_names: true)
      
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

    it 'returns an error when name is not supplied' do
      @viewing_party_fail = {
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id, @user2.id]
      }

      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_fail, as: :json
      expect(response).to have_http_status(400)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq("param is missing or the value is empty: name is required")
    end

    it 'returns an error when start_time is not supplied' do
      @viewing_party_fail = {
        name: "wally",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id, @user2.id]
      }

      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_fail, as: :json
      expect(response).to have_http_status(400)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq("param is missing or the value is empty: start_time is required")
    end

    it 'returns an error when end_time is not supplied' do
      @viewing_party_fail = {
        name: "wally",
        start_time: "2025-02-01 10:00:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id, @user2.id]
      }

      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_fail, as: :json
      expect(response).to have_http_status(400)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq("param is missing or the value is empty: end_time is required")
    end

    it 'returns an error when movie_id is not supplied' do
      @viewing_party_fail = {
        name: "wally",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id, @user2.id]
      }

      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_fail, as: :json
      expect(response).to have_http_status(400)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq("param is missing or the value is empty: movie_id is required")
    end

    it 'returns an error when movie_title is not supplied' do
      @viewing_party_fail = {
        name: "wally",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        invitees: [@user1.id, @user2.id]
      }

      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_fail, as: :json
      expect(response).to have_http_status(400)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq("param is missing or the value is empty: movie_title is required")
    end

    it 'returns an error when invitees is not supplied' do
      @viewing_party_fail = {
        name: "wally",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",

      }

      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_fail, as: :json
      expect(response).to have_http_status(400)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq("param is missing or the value is empty: invitees is required")
    end

    it 'it validates party duration less than run time' do
      @viewing_party_body_too_short = {
        name: "Wally's Party!",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 10:01:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id, @user2.id]
      }

      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_body_too_short, as: :json
      expect(response.status).to eq(400)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq("The party duration is less than the movie duration")
    end

    it 'it validates start time is before end time' do
      @viewing_party_body_end_before_start = {
        name: "Wally's Party!",
        start_time: "2025-02-01 15:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id, @user2.id]
      }

      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_body_end_before_start, as: :json
      expect(response.status).to eq(400)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:error]).to eq("The end time cannot be before the start time")
    end
    
    it 'it does not error if invitee does not exist' do
      @user2.destroy
      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_body, as: :json
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body, symbolize_names: true)
      
      expect(json[:data][:type]).to eq("viewing_party")
      expect(json[:data][:id]).to eq(ViewingParty.last.id)
      expect(json[:data][:attributes][:name]).to eq(@viewing_party_body[:name])
      expect(json[:data][:attributes][:start_time]).to eq(@viewing_party_body[:start_time])
      expect(json[:data][:attributes][:end_time]).to eq(@viewing_party_body[:end_time])
      expect(json[:data][:attributes][:movie_id]).to eq(@viewing_party_body[:movie_id])
      expect(json[:data][:attributes][:movie_title]).to eq(@viewing_party_body[:movie_title])
      expect(json[:data][:attributes][:invitees].length).to eq(1)
    end
  end
  
  describe 'add invitee to viewing party' do
    before :each do
      User.destroy_all
      @user1 = User.create!(name: "Wally", username: "www1", password: "abc123")
      @user2 = User.create!(name: "Wally2", username: "www2", password: "abc123")
      @user3 = User.create!(name: "Wally3", username: "www3", password: "abc123")
      @viewing_party_body = {
        name: "Wally's Party!",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id, @user2.id],
        host: @user1.id
      }
      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_body, as: :json
      @viewing_party1 = ViewingParty.last
    end

    it 'adds a viewing party invitee when a valid user is passed' do
      
      put "/api/v1/viewing_parties/#{@viewing_party1.id}", params: {invitee_user_id: @user3.id }, as: :json
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body, symbolize_names: true)
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
      expect(json[:data][:attributes][:invitees][2][:name]).to eq(@user3.name)
      expect(json[:data][:attributes][:invitees][2][:username]).to eq(@user3.username)
    end

    xit 'returns an error when an invalid user is passed' do

    end

    xit 'returns an error when an invalid viewing party is passed' do
      
    end
  end
end