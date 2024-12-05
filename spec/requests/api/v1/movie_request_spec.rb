require "rails_helper"

RSpec.describe "Movies API" do
  describe "top_movies" do
    it "gets the top movies" do
      VCR.use_cassette("top_20_movie_search") do
        get api_v1_top_movies_path
      end

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].length).to eq(20)
      expect(json[:data][0][:id]).to eq(1241982)
      expect(json[:data][0][:type]).to eq("movie")
      expect(json[:data][0][:attributes][:title]).to eq("Moana 2")
      expect(json[:data][0][:attributes][:vote_average]).to eq(6.9)
    end
  end
end