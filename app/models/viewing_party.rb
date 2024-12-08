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
      raise MissingInviteesError, "param is missing or the value is empty: invitees is required"
    end
    invitees.map do |invitee|
      if User.exists?(invitee)
        viewing_party_params = {viewing_party_id: viewing_party_id, user_id: invitee}
        ViewingPartyInvitee.create!(viewing_party_params)
      end
    end
  end

  def self.validate_viewing_party(viewing_party_attributes)
    validate_presence_of_required_fields(viewing_party_attributes)
    start_time = DateTime.parse(viewing_party_attributes[:start_time])
    end_time = DateTime.parse(viewing_party_attributes[:end_time])
    
    if end_time < start_time 
      raise EndBeforeStartError, "The end time cannot be before the start time"
    end

    movie_duration = get_movie_run_time(viewing_party_attributes[:movie_id])
    party_duration = (end_time - start_time) * 1440

    if party_duration < movie_duration
      raise TooShortError, "The party duration is less than the movie duration"
    end
  end

  private
  def self.validate_presence_of_required_fields(viewing_party_attributes)

    if !viewing_party_attributes.has_key?(:start_time)
      raise ActionController::ParameterMissing, "start_time is required"
    end
    if !viewing_party_attributes.has_key?(:end_time)
      raise ActionController::ParameterMissing, "end_time is required"
    end
    if !viewing_party_attributes.has_key?(:name)
      raise ActionController::ParameterMissing, "name is required"
    end
    if !viewing_party_attributes.has_key?(:movie_id)
      raise ActionController::ParameterMissing, "movie_id is required"
    end
    if !viewing_party_attributes.has_key?(:movie_title)
      raise ActionController::ParameterMissing, "movie_title is required"
    end
  end

  def self.get_movie_run_time(movie_id)
    100
  end
end