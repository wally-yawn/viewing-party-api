class Api::MoviesController < ApplicationController
  def show
    movie_details = MovieGateway.get_movie_details(params(:movie_id))
    movie = Movie.new(movie_details)
    render json: MovieSerializer.format_movie(movie)
  end
end