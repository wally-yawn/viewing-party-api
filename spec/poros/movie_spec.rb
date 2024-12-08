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

  it 'can create a movie from a movie details hash' do
    movie_data = {
      :id=>278,
      :title=>"The Shawshank Redemption",
      :vote_average=>8.708,
      :release_year=>1994,
      :runtime=>142,
      :genres=>[{:id=>18, :name=>"Drama"}, {:id=>80, :name=>"Crime"}],
      :summary=>
        "Imprisoned in the 1940s for the double murder of his wife and her lover, upstanding banker Andy Dufresne begins a new life at the Shawshank prison, where he puts his accounting skills to work for an amoral warden. During his long stretch in prison, Dufresne comes to be admired by the other inmates -- including an older prisoner named Red -- for his integrity and unquenchable sense of hope.",
      :cast=>
        [{:adult=>false,
          :gender=>2,
          :id=>504,
          :known_for_department=>"Acting",
          :name=>"Tim Robbins",
          :original_name=>"Tim Robbins",
          :popularity=>31.917,
          :profile_path=>"/djLVFETFTvPyVUdrd7aLVykobof.jpg",
          :cast_id=>3,
          :character=>"Andy Dufresne",
          :credit_id=>"52fe4231c3a36847f800b131",
          :order=>0},
        {:adult=>false,
          :gender=>2,
          :id=>192,
          :known_for_department=>"Acting",
          :name=>"Morgan Freeman",
          :original_name=>"Morgan Freeman",
          :popularity=>66.97,
          :profile_path=>"/jPsLqiYGSofU4s6BjrxnefMfabb.jpg",
          :cast_id=>4,
          :character=>"Ellis Boyd 'Red' Redding",
          :credit_id=>"52fe4231c3a36847f800b135",
          :order=>1},
        {:adult=>false,
          :gender=>2,
          :id=>4029,
          :known_for_department=>"Acting",
          :name=>"Bob Gunton",
          :original_name=>"Bob Gunton",
          :popularity=>18.59,
          :profile_path=>"/ulbVvuBToBN3aCGcV028hwO0MOP.jpg",
          :cast_id=>5,
          :character=>"Warden Norton",
          :credit_id=>"52fe4231c3a36847f800b139",
          :order=>2},
        {:adult=>false,
          :gender=>2,
          :id=>6573,
          :known_for_department=>"Acting",
          :name=>"William Sadler",
          :original_name=>"William Sadler",
          :popularity=>22.909,
          :profile_path=>"/rWeb2kjYCA7V9MC9kRwRpm57YoY.jpg",
          :cast_id=>7,
          :character=>"Heywood",
          :credit_id=>"52fe4231c3a36847f800b13d",
          :order=>3},
        {:adult=>false,
          :gender=>2,
          :id=>6574,
          :known_for_department=>"Acting",
          :name=>"Clancy Brown",
          :original_name=>"Clancy Brown",
          :popularity=>46.084,
          :profile_path=>"/1JeBRNG7VS7r64V9lOvej9bZXW5.jpg",
          :cast_id=>8,
          :character=>"Captain Byron T. Hadley",
          :credit_id=>"52fe4231c3a36847f800b141",
          :order=>4},
        {:adult=>false,
          :gender=>2,
          :id=>6575,
          :known_for_department=>"Acting",
          :name=>"Gil Bellows",
          :original_name=>"Gil Bellows",
          :popularity=>18.659,
          :profile_path=>"/eCOIv2nSGnWTHdn88NoMyNOKWyR.jpg",
          :cast_id=>9,
          :character=>"Tommy",
          :credit_id=>"52fe4231c3a36847f800b145",
          :order=>5},
        {:adult=>false,
          :gender=>2,
          :id=>6577,
          :known_for_department=>"Acting",
          :name=>"James Whitmore",
          :original_name=>"James Whitmore",
          :popularity=>9.74,
          :profile_path=>"/nYMAbkfwFIgKK84vnLoQctI6vHg.jpg",
          :cast_id=>11,
          :character=>"Brooks Hatlen",
          :credit_id=>"52fe4231c3a36847f800b14d",
          :order=>6},
        {:adult=>false,
          :gender=>2,
          :id=>6576,
          :known_for_department=>"Acting",
          :name=>"Mark Rolston",
          :original_name=>"Mark Rolston",
          :popularity=>10.834,
          :profile_path=>"/hcrNRIptYMRXgkJ9k76BlQu6DQp.jpg",
          :cast_id=>10,
          :character=>"Bogs Diamond",
          :credit_id=>"52fe4231c3a36847f800b149",
          :order=>7},
        {:adult=>false,
          :gender=>2,
          :id=>12645,
          :known_for_department=>"Acting",
          :name=>"Jeffrey DeMunn",
          :original_name=>"Jeffrey DeMunn",
          :popularity=>8.883,
          :profile_path=>"/eSouAAduXaziFpqLw59AG55jtGY.jpg",
          :cast_id=>28,
          :character=>"1946 D.A.",
          :credit_id=>"540dc040c3a36879b200546e",
          :order=>8},
        {:adult=>false,
          :gender=>2,
          :id=>92119,
          :known_for_department=>"Acting",
          :name=>"Larry Brandenburg",
          :original_name=>"Larry Brandenburg",
          :popularity=>4.593,
          :profile_path=>"/y13c1a4keaLnoTbi3dERwolQXWP.jpg",
          :cast_id=>29,
          :character=>"Skeet",
          :credit_id=>"542eb4a5c3a3680439000009",
          :order=>9}],
      :total_reviews=>16,
      :reviews=>
      [{:author=>"elshaarawy",
        :author_details=>{:name=>"", :username=>"elshaarawy", :avatar_path=>nil, :rating=>9.0},
        :content=>"very good movie 9.5/10 محمد الشعراوى",
        :created_at=>"2016-04-29 18:08:41 UTC",
        :id=>"5723a329c3a3682e720005db",
        :updated_at=>"2021-06-23 15:57:47 UTC",
        :url=>"https://www.themoviedb.org/review/5723a329c3a3682e720005db"},
      {:author=>"John Chard",
        :author_details=>{:name=>"", :username=>"John Chard", :avatar_path=>"/utEXl2EDiXBK6f41wCLsvprvMg4.jpg", :rating=>10.0},
        :content=>
        "Some birds aren't meant to be caged.\r\n\r\nThe Shawshank Redemption is written and directed by Frank Darabont. It is an adaptation of the Stephen King novella Rita Hayworth and Shawshank R
        edemption. Starring Tim Robbins and Morgan Freeman, the film portrays the story of Andy Dufresne (Robbins), a banker who is sentenced to two life sentences at Shawshank State Prison for apparentl
        y murdering his wife and her lover. Andy finds it tough going but finds solace in the friendship he forms with fellow inmate Ellis \"Red\" Redding (Freeman). While things start to pick up when th
        e warden finds Andy a prison job more befitting his talents as a banker. However, the arrival of another inmate is going to vastly change things for all of them.\r\n\r\nThere was no fanfare or bu
        nting put out for the release of the film back in 94, with a title that didn't give much inkling to anyone about what it was about, and with Columbia Pictures unsure how to market it, Shawshank R
        edemption barely registered at the box office. However, come Academy Award time the film received several nominations, and although it won none, it stirred up interest in the film for its home en
        tertainment release. The rest, as they say, is history. For the film finally found an audience that saw the film propelled to almost mythical proportions as an endearing modern day classic. Somet
        hing that has delighted its fans, whilst simultaneously baffling its detractors. One thing is for sure, though, is that which ever side of the Shawshank fence you sit on, the film continues to ga
        ther new fans and simply will never go away or loose that mythical status.\r\n\r\nIt's possibly the simplicity of it all that sends some haters of the film into cinematic spasms. The implausible 
        plot and an apparent sentimental edge that makes a nonsense of prison life, are but two chief complaints from those that dislike the film with a passion. Yet when characters are this richly drawn
        , and so movingly performed, it strikes me as churlish to do down a human drama that's dealing in hope, friendship and faith. The sentimental aspect is indeed there, but that acts as a counterpoi
        nt to the suffering, degradation and shattering of the soul involving our protagonist. Cosy prison life you say? No chance. The need for human connection is never more needed than during incarcer
        ation, surely? And given the quite terrific performances of Robbins (never better) & Freeman (sublimely making it easy), it's the easiest thing in the world to warm to Andy and Red.\r\n\r\nThose 
        in support aren't faring too bad either. Bob Gunton is coiled spring smarm as Warden Norton, James Whitmore is heart achingly great as the \"Birdman Of Shawshank,\" Clancy Brown is menacing as an
        tagonist Capt. Byron Hadley, William Sadler amusing as Heywood & Mark Rolston is impressively vile as Bogs Diamond. Then there's Roger Deakins' lush cinematography as the camera gracefully glides
          in and out of the prison offering almost ethereal hope to our characters (yes, they are ours). The music pings in conjunction with the emotional flow of the movie too. Thomas Newman's score is m
        ostly piano based, dovetailing neatly with Andy's state of mind, while the excellently selected soundtrack ranges from the likes of Hank Williams to the gorgeous Le Nozze di Figaro by Mozart.\r\n
        \r\nIf you love Shawshank then it's a love that lasts a lifetime. Every viewing brings the same array of emotions - anger - revilement - happiness - sadness - inspiration and a warmth that can re
        duce the most hardened into misty eyed wonderment. Above all else, though, Shawshank offers hope - not just for characters in a movie - but for a better life and a better world for all of us. 10/
        10",
        :created_at=>"2016-07-10 00:16:50 UTC",
        :id=>"578193f29251417c28001764",
        :updated_at=>"2024-05-16 15:22:14 UTC",
        :url=>"https://www.themoviedb.org/review/578193f29251417c28001764"},
      {:author=>"tmdb73913433",
        :author_details=>{:name=>"", :username=>"tmdb73913433", :avatar_path=>nil, :rating=>6.0},
        :content=>"Make way for the best film ever made people. **Make way.**",
        :created_at=>"2017-11-11 15:09:34 UTC",
        :id=>"5a0712aec3a3687914014a4b",
        :updated_at=>"2021-06-23 15:58:02 UTC",
        :url=>"https://www.themoviedb.org/review/5a0712aec3a3687914014a4b"},
      {:author=>"thommo_nz",
        :author_details=>{:name=>"", :username=>"thommo_nz", :avatar_path=>nil, :rating=>10.0},
        :content=>
        "There is a reason why this movie is at the top of any popular list your will find.\r\nVery strong performances from lead actors and a story line from the literary brilliance of Stephen King
      (and no, its not a horror).\r\nSufficient drama and depth to keep you interested and occupied without stupefying your brain. It is the movie that has something for everyone.",
        :created_at=>"2018-05-01 05:51:13 UTC",
        :id=>"5ae800510e0a264fa7000c70",
        :updated_at=>"2021-06-23 15:58:08 UTC",
        :url=>"https://www.themoviedb.org/review/5ae800510e0a264fa7000c70"},
        {:author=>"Andrew Gentry",
        :author_details=>{:name=>"Andrew Gentry", :username=>"AndrewGentry", :avatar_path=>"/vVGgWZe3bDdy0fsODYDtrL8J51b.jpg", :rating=>nil},
        :content=>
        "It's still puzzling to me why this movie exactly continues to appear in every single best-movies-of-all-time chart. There's a great story, perfect cast, and acting. It really moves me in ti
        mes when I'm finding myself figuring out things with my annual tax routine reading <a href=\"https://www.buzzfeed.com/davidsmithjd/what-is-form-w-2-and-how-does-it-work-3n31d\">this article</a>, 
        and accidentally catching myself wondering what my life should be if circumstances had changed so drastically. This movie worth a rewatch by all means, but yet, there's no unique vibe or somethin
        g - there are thousands of other ones as good as this one.",
        :created_at=>"2018-10-18 15:08:48 UTC",
        :id=>"5bc8a200c3a36829c8019817",
        :updated_at=>"2021-06-23 15:58:13 UTC",
        :url=>"https://www.themoviedb.org/review/5bc8a200c3a36829c8019817"}]}


    movie = Movie.new(movie_data)
    expect(movie).to be_an_instance_of(Movie)
    expect(movie.id).to eq(278)
    expect(movie.title).to eq("The Shawshank Redemption")
    expect(movie.release_year).to eq(1994)
    expect(movie.vote_average).to eq(8.708)
    expect(movie.runtime).to eq(142)
    expect(movie.genres.length).to eq(2)
    expect(movie.genres[0]).to eq("Drama")
    expect(movie.genres[1]).to eq("Crime")
    expect(movie.summary).to include("Imprisoned")
    expect(movie.cast.length).to eq(10)
    expect(movie.cast[0]).to eq({
          "character" => "Andy Dufresne",
          "actor" => "Tim Robbins"
        })
    expect(movie.total_reviews).to eq(16)
    expect(movie.reviews.length).to eq(5)
    expect(movie.reviews[1]).to eq({
      "author" => "John Chard",
      "review"=> "Some birds aren't meant to be caged.\r\n\r\nThe Shawshank Redemption is written and directed by Frank Darabont. It is an adaptation of the Stephen King novella Rita Hayworth and Shawshank R\n        edemption. Starring Tim Robbins and Morgan Freeman, the film portrays the story of Andy Dufresne (Robbins), a banker who is sentenced to two life sentences at Shawshank State Prison for apparentl\n        y murdering his wife and her lover. Andy finds it tough going but finds solace in the friendship he forms with fellow inmate Ellis \"Red\" Redding (Freeman). While things start to pick up when th\n        e warden finds Andy a prison job more befitting his talents as a banker. However, the arrival of another inmate is going to vastly change things for all of them.\r\n\r\nThere was no fanfare or bu\n        nting put out for the release of the film back in 94, with a title that didn't give much inkling to anyone about what it was about, and with Columbia Pictures unsure how to market it, Shawshank R\n        edemption barely registered at the box office. However, come Academy Award time the film received several nominations, and although it won none, it stirred up interest in the film for its home en\n        tertainment release. The rest, as they say, is history. For the film finally found an audience that saw the film propelled to almost mythical proportions as an endearing modern day classic. Somet\n        hing that has delighted its fans, whilst simultaneously baffling its detractors. One thing is for sure, though, is that which ever side of the Shawshank fence you sit on, the film continues to ga\n        ther new fans and simply will never go away or loose that mythical status.\r\n\r\nIt's possibly the simplicity of it all that sends some haters of the film into cinematic spasms. The implausible \n        plot and an apparent sentimental edge that makes a nonsense of prison life, are but two chief complaints from those that dislike the film with a passion. Yet when characters are this richly drawn\n        , and so movingly performed, it strikes me as churlish to do down a human drama that's dealing in hope, friendship and faith. The sentimental aspect is indeed there, but that acts as a counterpoi\n        nt to the suffering, degradation and shattering of the soul involving our protagonist. Cosy prison life you say? No chance. The need for human connection is never more needed than during incarcer\n        ation, surely? And given the quite terrific performances of Robbins (never better) & Freeman (sublimely making it easy), it's the easiest thing in the world to warm to Andy and Red.\r\n\r\nThose \n        in support aren't faring too bad either. Bob Gunton is coiled spring smarm as Warden Norton, James Whitmore is heart achingly great as the \"Birdman Of Shawshank,\" Clancy Brown is menacing as an\n        tagonist Capt. Byron Hadley, William Sadler amusing as Heywood & Mark Rolston is impressively vile as Bogs Diamond. Then there's Roger Deakins' lush cinematography as the camera gracefully glides\n          in and out of the prison offering almost ethereal hope to our characters (yes, they are ours). The music pings in conjunction with the emotional flow of the movie too. Thomas Newman's score is m\n        ostly piano based, dovetailing neatly with Andy's state of mind, while the excellently selected soundtrack ranges from the likes of Hank Williams to the gorgeous Le Nozze di Figaro by Mozart.\r\n\n        \r\nIf you love Shawshank then it's a love that lasts a lifetime. Every viewing brings the same array of emotions - anger - revilement - happiness - sadness - inspiration and a warmth that can re\n        duce the most hardened into misty eyed wonderment. Above all else, though, Shawshank offers hope - not just for characters in a movie - but for a better life and a better world for all of us. 10/\n        10"
    })
  end

end