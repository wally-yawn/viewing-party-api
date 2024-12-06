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
end