class Api::V1::MoviesController < ApplicationController
  rescue_from InvalidMovieError, with: :handle_invalid_movie

  def show
    movie_details = MovieGateway.get_movie_details(params[:id])
    movie = Movie.new(movie_details)
    render json: MovieSerializer.format_movie(movie)
  end

  private
  def handle_invalid_movie(exception)
    render json: { error: exception.message }, status: 404
  end
end