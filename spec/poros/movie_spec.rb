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
    movie2 = Movie.new(movie_data)
    expect(movie2).to be_an_instance_of(Movie)
    expect(movie2.id).to eq(1241982)
    expect(movie2.title).to eq("Moana 2")
    expect(movie2.vote_average).to eq(7.0)
  end

  xit 'can create a movie from a movie details hash' do
    
  end

end