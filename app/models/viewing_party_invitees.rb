class ViewingPartyInvitees < ApplicationRecord
  has_many :users
  has_many :viewing_partys
end