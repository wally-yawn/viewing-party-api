class MovieGateway

  def self.conn
    Faraday.new(url: "https://api.themoviedb.org/")
  end

  def self.get_top_20_movies
    response = conn.get("3/discover/movie", { query: "sort_by=popularity.desc", api_key: Rails.application.credentials.tmdb[:key] })
    return_movies(response)

  end

  def self.search_movies(params)
    response = conn.get("3/search/movie", { query: params, api_key: Rails.application.credentials.tmdb[:key] })
    return_movies(response)
  end

  def self.get_movie_details(movie_id)

  end

  private_class_method

  def self.return_movies(response)
    json = JSON.parse(response.body, symbolize_names: true)
    movies_results = json[:results].take(20)
    movies = []
    movies_results.map do |movie_result|
      movies << Movie.new(movie_result)
    end
    movies
  end
end