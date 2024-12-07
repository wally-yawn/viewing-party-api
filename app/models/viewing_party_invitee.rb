class ViewingPartyInvitee < ApplicationRecord
  belongs_to :user
  belongs_to :viewing_party

  validates :user_id, presence: true
  validates :viewing_party_id, presence: true

  def self.create_viewing_party_invitees(viewing_party_id, invitees)
    invitees.map do |invitee|
      ViewingPartyInvitee.create!(viewing_party_id, invitee)
    end
  end
end