class Api::V1::MoviesController < ApplicationController
  def show
    # require 'pry'; binding.pry
    movie_details = MovieGateway.get_movie_details(params[:id])
    movie = Movie.new(movie_details)
    render json: MovieSerializer.format_movie(movie)
  end
end