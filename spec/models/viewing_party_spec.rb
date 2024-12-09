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
    before :each do
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
    end

    it 'can create viewing party invitees from an array of invitees' do
      ViewingParty.create_viewing_party_invitees(@viewing_party1.id, [@user1.id,@user2.id])
      expect(ViewingPartyInvitee.all.length).to eq(2)
    end

    it 'returns an error when invitees are missing' do
      expect { ViewingParty.create_viewing_party_invitees(@viewing_party1.id, [@user1.id,@user2.id]).to raise_error(EndBeforeStartError) }
    end
  end

  describe 'validate_viewing_party' do
    before :each do
      User.destroy_all
      @user1 = User.create!(name: "Wally", username: "www1", password: "abc123")
    end

    it 'it validates party duration less than run time' do
      @viewing_party_params_short = {
        name: "Wally's Party!",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 10:01:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        host: @user1.id
      }
      expect { ViewingParty.validate_viewing_party(@viewing_party_params_short) }.to raise_error(TooShortError)
    end

    it 'it validates start time is before end time' do
      @viewing_party_params_end = {
        name: "Wally's Party!",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 09:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption",
        host: @user1.id
      }

      expect { ViewingParty.validate_viewing_party(@viewing_party_params_end) }.to raise_error(EndBeforeStartError)
    end

    it 'returns an error when name is not supplied' do
      @viewing_party_fail = {
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption"
      }

      expect { ViewingParty.validate_viewing_party(@viewing_party_fail) }.to raise_error(ActionController::ParameterMissing)
    end

    it 'returns an error when start_time is not supplied' do
      @viewing_party_fail = {
        name: "wally",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption"
      }

      expect {ViewingParty.validate_viewing_party(@viewing_party_fail) }.to raise_error(ActionController::ParameterMissing)
    end

    it 'returns an error when end_time is not supplied' do
      @viewing_party_fail = {
        name: "wally",
        start_time: "2025-02-01 10:00:00",
        movie_id: 278,
        movie_title: "The Shawshank Redemption"
      }

      expect {ViewingParty.validate_viewing_party(@viewing_party_fail) }.to raise_error(ActionController::ParameterMissing)
    end

    it 'returns an error when movie_id is not supplied' do
      @viewing_party_fail = {
        name: "wally",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_title: "The Shawshank Redemption"
      }

      expect {ViewingParty.validate_viewing_party(@viewing_party_fail) }.to raise_error(ActionController::ParameterMissing)
    end

    it 'returns an error when movie_title is not supplied' do
      @viewing_party_fail = {
        name: "wally",
        start_time: "2025-02-01 10:00:00",
        end_time: "2025-02-01 14:30:00",
        movie_id: 278
      }

      expect {ViewingParty.validate_viewing_party(@viewing_party_fail) }.to raise_error(ActionController::ParameterMissing)
    end
  end

  describe 'get_movie_run_time' do
    it 'gets the movie run time for a given movie', :vcr do
      expect(ViewingParty.get_movie_run_time(278)).to eq(142)
    end
  end
end