class ViewingPartyInvitee < ApplicationRecord
  belongs_to :user
  belongs_to :viewing_party

  validates :user_id, presence: true
  validates :viewing_party_id, presence: true

end