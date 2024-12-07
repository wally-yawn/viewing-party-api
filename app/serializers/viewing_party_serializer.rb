class ViewingPartySerializer

  def self.format_viewing_party(viewing_party)
    { data: 
      {
        id: viewing_party.id,
        type: "viewing_party",
        attributes: {
          name: viewing_party.name,
          start_time: viewing_party.start_time,
          end_time: viewing_party.end_time,
          movie_id: viewing_party.movie_id,
          movie_title: viewing_party.movie_title,
          invitees: ViewingPartyInviteeSerializer.format_viewing_party_users(viewing_party.viewing_party_invitees)
        }
      }
    }
  end
end