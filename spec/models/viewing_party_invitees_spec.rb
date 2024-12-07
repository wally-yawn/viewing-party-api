require "rails_helper"

RSpec.describe ViewingPartyInvitee, type: :model do
  describe 'relationships' do
    it { should belong_to :user}
    it { should belong_to :viewing_party}
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:viewing_party_id) }
  end

  describe 'create_viewing_party_invitees' do
    it 'can create viewing party invitees from an array of invitees' do
      User.destroy_all
      @user1 = User.create!(name: "Wally", username: "www1", password: "abc123")
      @user2 = User.create!(name: "Wally2", username: "www2", password: "abc123")
      @viewing_party_params = {
        name: "Wally's Party!",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
      }
      @viewing_party1 = ViewingParty.create!(@viewing_party_params)

      ViewingPartyInvitee.create_viewing_party_invitees(@viewing_party1.id, [@user1.id,@user2.id])
      require 'pry'; binding.pry
    end
  end
end