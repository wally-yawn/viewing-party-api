class Movie

  attr_reader :id, :title, :vote_average, :release_year, :runtime, :genres, :summary, :cast, :total_reviews, :reviews

  def initialize(movie_data)
    @id = movie_data[:id]
    @title = movie_data[:title]
    @vote_average = movie_data[:vote_average]
    @release_year = movie_data[:release_year]
    @runtime = movie_data[:runtime]
    @genres = clean_genres(movie_data[:genres])
    @summary = movie_data[:summary]
    @cast = clean_cast(movie_data[:cast])
    @total_reviews = movie_data[:total_reviews]
    @reviews = clean_reviews(movie_data[:reviews])
  end

  private
  def clean_cast(cast)
    if cast == nil
      return nil
    end

    clean_cast_array = []
    cast.map do |cast_member|
      cast_credit = {
        "character" => cast_member[:character],
        "actor" => cast_member[:name]
      }
      clean_cast_array << cast_credit
    end
    clean_cast_array
  end

  def clean_genres(genres)
    if genres == nil
      return nil
    end

    clean_genres_array = []
    genres.map do |genre|
      clean_genres_array << genre[:name]
    end
    clean_genres_array
  end

  def clean_reviews(reviews)
    if reviews == nil
      return nil
    end

    clean_reviews_array = []
    reviews.map do |review|
      clean_review = {
        "author" => review[:author],
        "review" => review[:content]
      }
      clean_reviews_array << clean_review
    end
    clean_reviews_array
  end
end