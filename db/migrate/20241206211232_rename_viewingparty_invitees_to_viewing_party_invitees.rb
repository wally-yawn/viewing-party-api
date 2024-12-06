class RenameViewingpartyInviteesToViewingPartyInvitees < ActiveRecord::Migration[7.1]
  def change
    rename_table :viewingparty_invitees, :viewing_party_invitees
  end
end
