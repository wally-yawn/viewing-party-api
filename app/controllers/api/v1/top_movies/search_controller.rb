class Api::V1::TopMovies::SearchController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :handle_missing_keyword

  def index
    movies = MovieGateway.search_movies(search_params)
    render json: MovieSerializer.format_movie_list(movies)
  end
end

private
def search_params
  params.require(:keyword)
end

def handle_missing_keyword(exception)
  render json: { error: exception.message }, status: :bad_request
end