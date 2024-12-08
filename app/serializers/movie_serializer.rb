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

  def format_movie(movie)
    puts 'implement format_movie'
  end
end