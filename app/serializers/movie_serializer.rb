class MovieSerializer
  include JSONAPI::Serializer
  attributes :original_title, :popularity

  def self.format_movie_list(movies)
    { data: 
      movies.map do |movie|
        {
        id: movie.id,
        type: "movie",
          attributes: {
            title: movie.title,
            vote_average: movie.vote_average
          }
        }
      end
    }
  end

  def self.format_movie(movie)
    { data:
      {
        id: movie.id,
        type: "movie",
          attributes: {
            title: movie.title,
            release_year: movie.release_year,
            vote_average: movie.vote_average,
            runtime: format_run_time(movie.runtime),
            genres: movie.genres,
            summary: movie.summary,
            cast: movie.cast,
            total_reviews: movie.total_reviews,
            reviews: movie.reviews
          }
        }
      }
    end

  private 

  def self.format_run_time(runtime_in_minutes)
    hours = runtime_in_minutes / 60
    minutes = runtime_in_minutes % 60
    formatted_run_time = "#{hours} hours, #{minutes} minutes"
  end
end