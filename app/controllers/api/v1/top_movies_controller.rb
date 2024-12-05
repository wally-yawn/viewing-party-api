class Api::V1::TopMoviesController < ApplicationController
  
  def index
    #make one call but send in params, gateway can handle what to do with it
    movies = MovieGateway.get_top_20_movies
    render json: MovieSerializer.format_movie_list(movies)
  end
end