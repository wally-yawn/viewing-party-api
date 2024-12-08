class ViewingParty < ApplicationRecord

  attr_accessor :invitees
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true
  validates :host, presence: true
  has_many :viewing_party_invitees
  has_many :users, through: :viewing_party_invitees

  def self.create_viewing_party_invitees(viewing_party_id, invitees)
    if invitees == nil
      raise MissingInviteesError, "Missing invitees"
    end
    invitees.map do |invitee|
      viewing_party_params = {viewing_party_id: viewing_party_id, user_id: invitee}
      ViewingPartyInvitee.create!(viewing_party_params)
    end
  end

  def self.validate_viewing_party(viewing_party_attributes)
    start_time = DateTime.parse(viewing_party_attributes[:start_time])
    end_time = DateTime.parse(viewing_party_attributes[:end_time])
    if end_time < start_time 
      raise EndBeforeStartError, "The end time cannot be before the start time"
    end
  end
end