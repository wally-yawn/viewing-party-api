class Api::MoviesController < ApplicationController
  def show
    movie = MovieGateway.get_movie_details(params(:movie_id))
    render json: MovieSerializer.format_movie(movie)
  end
end