class Api::V1::ViewingPartyInviteesController < ApplicationController
  rescue_from MissingInviteesError, with: :handle_exception
  rescue_from TooShortError, with: :handle_exception
  rescue_from EndBeforeStartError, with: :handle_exception
  rescue_from ActionController::ParameterMissing, with: :handle_exception

  def update
    attributes = {user_id: viewing_party_invitee_params[:invitee_user_id], viewing_party_id: params[:id]}
    ViewingPartyInvitee.create!(attributes)
    render json: ViewingPartySerializer.format_viewing_party(ViewingParty.find(params[:id])), status: :created
  end

  private

  def viewing_party_invitee_params
    params.permit(:invitee_user_id, :id)
  end

  def handle_exception(exception)
    render json: { error: exception.message }, status: 400
  end
end