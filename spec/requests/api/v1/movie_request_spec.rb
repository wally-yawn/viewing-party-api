require "rails_helper"

RSpec.describe "Movies API" do
  describe "top_movies" do
    it "gets the top movies" do
      VCR.use_cassette("top_20_movie_search") do
        get "/api/v1/top_movies"
      end

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].length).to eq(20)
      expect(json[:data][0][:id]).to eq(1241982)
      expect(json[:data][0][:type]).to eq("movie")
      expect(json[:data][0][:attributes][:title]).to eq("Moana 2")
      expect(json[:data][0][:attributes][:vote_average]).to eq(6.9)
    end

    it "gets the top movies based on a search term" do
      VCR.use_cassette("top_20_movie_search_with_keywords") do
        get "/api/v1/top_movies/search?keyword=godzilla"
      end

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].length).to eq(20)
      expect(json[:data][4][:id]).to eq(940721)
      expect(json[:data][4][:type]).to eq("movie")
      expect(json[:data][4][:attributes][:title]).to eq("Godzilla Minus One")
      expect(json[:data][4][:attributes][:vote_average]).to eq(7.6)
    end

    it "returns an error if the keyword is not supplied" do
      search_params = { keyword: nil}
      get "/api/v1/top_movies/search", params:{}
      
      expect(response.status).to eq(400)
      expect(JSON.parse(response.body)).to eq({ "error" => "param is missing or the value is empty: keyword" })
    end
  end

  describe "movie_details" do
    it 'gets the movie details for a valid movie', :vcr do
      get "/api/v1/movies/278"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry
      expect(json[:data][:id]).to eq(278)
      expect(json[:data][:type]).to eq("movie")
      expect(json[:data][:attributes][:title]).to eq("The Shawshank Redemption")
      expect(json[:data][:attributes][:release_year]).to eq(1994)
      expect(json[:data][:attributes][:vote_average]).to eq(8.708)
      expect(json[:data][:attributes][:runtime]).to eq("2 hours, 22 minutes")
      expect(json[:data][:attributes][:genres].length).to eq(2)
      expect(json[:data][:attributes][:genres][0]).to eq("Drama")
      expect(json[:data][:attributes][:genres][1]).to eq("Crime")
      expect(json[:data][:attributes][:summary]).to include("Imprisoned")
      expect(json[:data][:attributes][:cast].length).to eq(10)
      expect(json[:data][:attributes][:cast][0]).to eq({
            character: "Andy Dufresne",
            actor: "Tim Robbins"
          })
      expect(json[:data][:attributes][:total_reviews]).to eq(16)
      expect(json[:data][:attributes][:reviews].length).to eq(5)
      expect(json[:data][:attributes][:reviews][1][:author]).to eq("John Chard")
      expect(json[:data][:attributes][:reviews][1][:review]).to include("Some birds aren't meant to be caged")
    end

    xit 'returns an error for an invalid movie' do

    end
  end
end