require "rails_helper"

RSpec.describe ViewingPartyInvitees, type: :model do
  describe 'relationships' do
    it { should have_many :users}
    it { should have_many :viewing_partys}
  end
end