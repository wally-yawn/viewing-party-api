require "rails_helper"

RSpec.describe "Movies API" do
  describe "top_movies" do
    it "gets the top movies", :vcr do
      get api_v1_movies_path

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data].length).to eq(20)
      expect(json[:data][0][:id]).to be_a(Integer)
    end
  end
end