require "rails_helper"

RSpec.describe MovieGateway do
  it 'gets the top 20 movies', :vcr do
    movies = MovieGateway.get_top_20_movies
    expect(movies.length).to eq(20)
    expect(movies[0].title).to eq("Moana 2")
  end

  it 'gets movies based on a search', :vcr do
    movies = MovieGateway.search_movies("bond")
    expect(movies.length).to eq(20)
    expect(movies[0].title).to eq("Demon Slayer: Kimetsu no Yaiba – Sibling's Bond")
  end
end