class Api::V1::ViewingPartyInviteesController < ApplicationController
  rescue_from MissingInviteesError, with: :handle_exception
  rescue_from ActiveRecord::RecordInvalid, with: :handle_exception

  def update
    attributes = {user_id: viewing_party_invitee_params[:invitees_user_id], viewing_party_id: params[:id]}
    ViewingPartyInvitee.create!(attributes)
    render json: ViewingPartySerializer.format_viewing_party(ViewingParty.find(params[:id])), status: :created
  end

  private

  def viewing_party_invitee_params
    params.permit(:invitees_user_id, :id)
  end

  def handle_exception(exception)
    nice_message = exception.message.split(": ").last
    render json: { error: nice_message }, status: 422
  end
end