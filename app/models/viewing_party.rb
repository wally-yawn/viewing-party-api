class ViewingParty < ApplicationRecord

  attr_accessor :invitees
  
  validates :name, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :movie_id, presence: true
  validates :movie_title, presence: true
  validate :invitees_present
  has_many :viewing_party_invitees
  has_many :users, through: :viewing_party_invitees

  def invitees_present
    errors.add(:invitees, "can't be blank") if invitees.blank?
  end
end