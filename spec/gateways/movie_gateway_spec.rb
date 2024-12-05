require "rails_helper"

RSpec.describe MovieGateway do
  it 'gets the top 20 movies', :vcr do
    movies = MovieGateway.get_top_20_movies
    expect(movies.length).to eq(20)
    expect(movies[0].title).to eq("Moana 2")
  end
end