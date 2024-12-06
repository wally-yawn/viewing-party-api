class ViewingParty < ApplicationRecord
  has_many :viewing_party_invitees
  has_many :users, through: :viewing_party_invitees
end