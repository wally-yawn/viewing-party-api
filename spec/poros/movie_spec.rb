require "rails_helper"

RSpec.describe Movie do
  it 'can create a movie from a top movies json hash' do
    movie_data = {
      :adult=>false,
      :backdrop_path=>"/tElnmtQ6yz1PjN1kePNl8yMSb59.jpg",
      :genre_ids=>[16, 12, 10751, 35],
      :id=>1241982,
      :original_language=>"en",
      :original_title=>"Moana 2",
      :overview=>
      "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced.",
      :popularity=>5883.763,
      :poster_path=>"/yh64qw9mgXBvlaWDi7Q9tpUBAvH.jpg",
      :release_date=>"2024-11-27",
      :title=>"Moana 2",
      :video=>false,
      :vote_average=>7.0,
      :vote_count=>324
    }
    movie = Movie.new(movie_data)
    expect(movie).to be_an_instance_of(Movie)
    expect(movie.id).to eq(1241982)
    expect(movie.title).to eq("Moana 2")
    expect(movie.vote_average).to eq(7.0)
  end

  xit 'can create a movie from a movie details hash' do
    movie_data = {}

    movie = Movie.new(movie_data)
    expect(movie).to be_an_instance_of(Movie)
    expect(movie.id).to eq(278)
    expect(movie.title).to eq("The Shawshank Redemption")
    expect(movie.release_year).to eq(1994)
    expect(movie.vote_average).to eq(8.706)
    expect(movie.runtime).to eq(142)
    expect(movie.genre.length).to eq(2)
    expect(movie.genre[0]).to eq("Drama")
    expect(movie.genre[1]).to eq("Crime")
    expect(movie.summary).to include("Imprisoned")
    expect(movie.cast.length).to eq(10)
    expect(movie.cast[0]).to eq({
          "character": "Andy Dufresne",
          "actor": "Tim Robbins"
        })
    expect(movie.total_reviews).to eq(14)
    expect(movie.reviews.length).to eq(5)
    expect(movie.reviews[1]).to eq({
      "author": "John Chard",
      "review": "Some birds aren't meant to be caged.\r\n\r\nThe Shawshank Redemption is written and directed by Frank Darabont. It is an adaptation of the Stephen King novella Rita Hayworth and Shawshank Redemption..."
    })
  end

end