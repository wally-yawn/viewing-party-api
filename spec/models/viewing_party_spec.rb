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
    it { should validate_presence_of(:host) }
  end

  describe 'create_viewing_party_invitees' do
    it 'can create viewing party invitees from an array of invitees' do
      User.destroy_all
      ViewingPartyInvitee.destroy_all
      @user1 = User.create!(name: "Wally", username: "www1", password: "abc123")
      @user2 = User.create!(name: "Wally2", username: "www2", password: "abc123")
      @viewing_party_params = {
        name: "Wally's Party!",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        host: @user1.id
      }
      @viewing_party1 = ViewingParty.create!(@viewing_party_params)

      ViewingParty.create_viewing_party_invitees(@viewing_party1.id, [@user1.id,@user2.id])
      expect(ViewingPartyInvitee.all.length).to eq(2)
    end
  end

  describe 'validate_viewing_party' do
    xit 'it validates party duration less than run time' do

    end

    xit 'it validates start time is before end time' do

    end
    
    xit 'it does not error if invitee does not exist' do

    end
  end
end