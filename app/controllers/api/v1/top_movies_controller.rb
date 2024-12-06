class Api::V1::TopMoviesController < ApplicationController
  
  def index
    movies = MovieGateway.get_top_20_movies
    render json: MovieSerializer.format_movie_list(movies)
  end
end