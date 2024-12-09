require "rails_helper"

RSpec.describe "Users API", type: :request do
  describe "Create User Endpoint" do
    let(:user_params) do
      {
        name: "Me",
        username: "its_me",
        password: "QWERTY123",
        password_confirmation: "QWERTY123"
      }
    end

    context "request is valid" do
      it "returns 201 Created and provides expected fields" do
        post api_v1_users_path, params: user_params, as: :json

        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json[:data][:type]).to eq("user")
        expect(json[:data][:id]).to eq(User.last.id.to_s)
        expect(json[:data][:attributes][:name]).to eq(user_params[:name])
        expect(json[:data][:attributes][:username]).to eq(user_params[:username])
        expect(json[:data][:attributes]).to have_key(:api_key)
        expect(json[:data][:attributes]).to_not have_key(:password)
        expect(json[:data][:attributes]).to_not have_key(:password_confirmation)
      end
    end

    context "request is invalid" do
      it "returns an error for non-unique username" do
        User.create!(name: "me", username: "its_me", password: "abc123")

        post api_v1_users_path, params: user_params, as: :json
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:bad_request)
        expect(json[:message]).to eq("Username has already been taken")
        expect(json[:status]).to eq(400)
      end

      it "returns an error when password does not match password confirmation" do
        user_params = {
          name: "me",
          username: "its_me",
          password: "QWERTY123",
          password_confirmation: "QWERT123"
        }

        post api_v1_users_path, params: user_params, as: :json
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:bad_request)
        expect(json[:message]).to eq("Password confirmation doesn't match Password")
        expect(json[:status]).to eq(400)
      end

      it "returns an error for missing field" do
        user_params[:username] = ""

        post api_v1_users_path, params: user_params, as: :json
        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:bad_request)
        expect(json[:message]).to eq("Username can't be blank")
        expect(json[:status]).to eq(400)
      end
    end
  end

  describe "Get All Users Endpoint" do
    it "retrieves all users but does not share any sensitive data" do
      User.destroy_all
      User.create!(name: "Tom", username: "myspace_creator", password: "test123")
      User.create!(name: "Oprah", username: "oprah", password: "abcqwerty")
      User.create!(name: "Beyonce", username: "sasha_fierce", password: "blueivy")

      get api_v1_users_path

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data].count).to eq(3)
      expect(json[:data][0][:attributes]).to have_key(:name)
      expect(json[:data][0][:attributes]).to have_key(:username)
      expect(json[:data][0][:attributes]).to_not have_key(:password)
      expect(json[:data][0][:attributes]).to_not have_key(:password_digest)
      expect(json[:data][0][:attributes]).to_not have_key(:api_key)
    end
  end

  describe "get user profile" do
    before :each do
      User.destroy_all
      @user1 = User.create!(name: "wally1", username: "ww1", password: "abc123")
      @user2 = User.create!(name: "wally2", username: "ww2", password: "abc123")
      @viewing_party_body = {
        name: "Wally's Party!",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id],
      }
      post "/api/v1/viewing_parties/#{@user1.id}", params: @viewing_party_body, as: :json
      @viewing_party1 = ViewingParty.last
    end

    xit 'returns user which has not attended any parties' do
      get "/api/v1/users/#{@user2.id}"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:id]).to eq(@user2.id)
      expect(json[:data][:type]).to eq("user")
      expect(json[:data][:attributes][:name]).to eq(@user2.name)
      expect(json[:data][:attributes][:username]).to eq(@user2.username)
      expect(json[:data][:attributes][:viewing_parties_hosted]).to eq([])
      expect(json[:data][:attributes][:viewing_parties_invited]).to eq([])
    end

    xit 'returns user which has hosted and attended parties' do
      @viewing_party_body = {
        name: "Wally's Party 2!",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        invitees: [@user1.id, @user2.id],
      }
      post "/api/v1/viewing_parties/#{@user2.id}", params: @viewing_party_body, as: :json
      @viewing_party2 = ViewingParty.last

      get "/api/v1/users/#{@user1.id}"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:id]).to eq(@user1.id)
      expect(json[:data][:type]).to eq("user")
      expect(json[:data][:attributes][:name]).to eq(@user1.name)
      expect(json[:data][:attributes][:username]).to eq(@user1.username)
      expect(json[:data][:attributes][:viewing_parties_hosted].length).to eq([1])
      expect(json[:data][:attributes][:viewing_parties_invited].length).to eq([2])

      expect(json[:data][:attributes][:viewing_parties_hosted][0][:id]).to eq(@viewing_party1.id)
      expect(json[:data][:attributes][:viewing_parties_hosted][0][:name]).to eq(@viewing_party1.name)
      expect(json[:data][:attributes][:viewing_parties_hosted][0][:start_time]).to eq(@viewing_party1.start_time)
      expect(json[:data][:attributes][:viewing_parties_hosted][0][:end_time]).to eq(@viewing_party1.end_time)
      expect(json[:data][:attributes][:viewing_parties_hosted][0][:movie_id]).to eq(@viewing_party1.movie_id)
      expect(json[:data][:attributes][:viewing_parties_hosted][0][:movie_title]).to eq(@viewing_party1.title)
      expect(json[:data][:attributes][:viewing_parties_hosted][0][:host_id]).to eq(@viewing_party1.host_id)

      expect(json[:data][:attributes][:viewing_parties_invited][1][:id]).to eq(@viewing_party2.id)
      expect(json[:data][:attributes][:viewing_parties_invited][1][:name]).to eq(@viewing_party2.name)
      expect(json[:data][:attributes][:viewing_parties_invited][1][:start_time]).to eq(@viewing_party2.start_time)
      expect(json[:data][:attributes][:viewing_parties_invited][1][:end_time]).to eq(@viewing_party2.end_time)
      expect(json[:data][:attributes][:viewing_parties_invited][1][:movie_id]).to eq(@viewing_party2.movie_id)
      expect(json[:data][:attributes][:viewing_parties_invited][1][:movie_title]).to eq(@viewing_party2.title)
      expect(json[:data][:attributes][:viewing_parties_invited][1][:host_id]).to eq(@viewing_party2.host_id)
    end

    xit 'returns an error when the user does not exist' do
      @user1.destroy
      get "/api/v1/users/#{@user1.id}"
      expect(response.status).to eq(404)
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:error]).to eq("Invalid User ID")
    end
  end
end
