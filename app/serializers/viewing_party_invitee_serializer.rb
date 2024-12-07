class ViewingPartyInviteeSerializer

  def self.format_viewing_party_users(invitees)
      invitees.map do |invitee|
        {
          id: invitee.user.id,
          name: invitee.user.name,
          username: invitee.user.username
        }
      end
  end
end