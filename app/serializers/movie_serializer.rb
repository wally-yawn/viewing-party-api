class MovieSerializer
  include JSONAPI::Serializer
  attributes :original_title, :popularity

  def self.format_movie_list(movies)
    # require 'pry'; binding.pry
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
end