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
    it 'gets movie details', :vcr do
      movie_details = MovieGateway.get_movie_details(278)
      # require 'pry'; binding.pry
      expect(movie_details[:id]).to eq(278)
      expect(movie_details[:title]).to eq("The Shawshank Redemption")
      expect(movie_details[:release_year]).to eq(1994)
      expect(movie_details[:vote_average]).to eq(8.708)
      expect(movie_details[:runtime]).to eq(142)
      expect(movie_details[:genres].length).to eq(2)
      expect(movie_details[:genres][0]).to eq({:id=>18, :name=>"Drama"})
      expect(movie_details[:genres][1]).to eq({:id=>80, :name=>"Crime"})
      expect(movie_details[:summary]).to include("Imprisoned")
      expect(movie_details[:cast].length).to eq(10)
      expect(movie_details[:cast][0][:character]).to eq("Andy Dufresne")
      expect(movie_details[:total_reviews]).to eq(16)
      expect(movie_details[:reviews].length).to eq(5)
      expect(movie_details[:reviews][1][:author]).to eq("John Chard")
    end

    xit 'returns an error for an invalid movie', :vcr do
      movie = MovieGateway.get_movie_details
      # expect(movie)
    end
  end
end