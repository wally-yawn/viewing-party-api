require "rails_helper"

RSpec.describe ViewingParty, type: :model do
  describe 'associations' do
    it { should have_many :viewing_party_invitees}
    it { should have_many(:users).through(:viewing_party_invitees)  }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:movie_id) }
    it { should validate_presence_of(:movie_title) }
    it { should validate_presence_of(:invitees) }
  end
end