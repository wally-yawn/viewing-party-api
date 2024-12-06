class MovieGateway

  def self.conn
    Faraday.new(url: "https://api.themoviedb.org/")
  end

  def self.get_top_20_movies(params = nil) 
    if params != nil && params.has_key?("keywords")
      response = conn.get("3/search/movie", { query: params[:keywords], api_key: Rails.application.credentials.tmdb[:key] })
    else
      response = conn.get("3/discover/movie", { query: "sort_by", api_key: Rails.application.credentials.tmdb[:key] })
    end

    json = JSON.parse(response.body, symbolize_names: true)
    movies_results = json[:results].take(20)
    movies = []
    movies_results.map do |movie_result|
      movies << Movie.new(movie_result)
    end
    movies
  end

end