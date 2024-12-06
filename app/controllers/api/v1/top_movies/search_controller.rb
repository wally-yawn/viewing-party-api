class Api::V1::TopMovies::SearchController < ApplicationController
  
  def index
    # require 'pry'; binding.pry
    movies = MovieGateway.get_top_20_movies(params)
    render json: MovieSerializer.format_movie_list(movies)
  end
end