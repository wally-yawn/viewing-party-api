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
    response_details = conn.get("3/movie/#{movie_id}", { api_key: Rails.application.credentials.tmdb[:key] })
    if response_details.status == 404
      raise InvalidMovieError, "No movie with this id found"
    end

    details = JSON.parse(response_details.body, symbolize_names: true)
    
    response_credits = conn.get("3/movie/#{movie_id}/credits", { api_key: Rails.application.credentials.tmdb[:key] })
    credits = JSON.parse(response_credits.body, symbolize_names: true)
    
    response_reviews = conn.get("3/movie/#{movie_id}/reviews", { api_key: Rails.application.credentials.tmdb[:key] })
    reviews = JSON.parse(response_reviews.body, symbolize_names: true)
  
    movie_details = format_movie_response(details, credits, reviews)
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

  def self.format_movie_response(details, credits, reviews)
    movie_data = {
      id: details[:id],
      title: details[:title],
      release_year: details[:release_date].split("-")[0].to_i,
      vote_average: details[:vote_average],
      runtime: details[:runtime],
      genres: details[:genres],
      summary: details[:overview],
      cast: credits[:cast].first(10),
      total_reviews:  reviews[:results].length,
      reviews: reviews[:results].first(5)
    }
  end
end