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

  describe 'get_movie_details' do
    xit 'gets movie details', :vcr do
      movie = MovieGateway.get_movie_details
      # expect(movie_details)
    end

    xit 'returns an error for an invalid movie', :vcr do
      movie = MovieGateway.get_movie_details
      # expect(movie_details)
    end
  end
end