require "rails_helper"

RSpec.describe ViewingParty, type: :model do
  it { should have_many :viewing_party_invitees}
  it { should have_many(:users).through(:viewing_party_invitees)  }
end