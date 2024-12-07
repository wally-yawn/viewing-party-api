class Api::V1::ViewingPartiesController < ApplicationController
  rescue_from MissingInviteesError, with: :handle_missing_invitees

  def create
    viewing_party_attributes = viewing_party_params.to_h
    viewing_party_attributes[:host] = params[:host_id]
    viewing_party = ViewingParty.create!(viewing_party_attributes)
    viewing_party_invitee_params = {viewing_party_id: viewing_party.id, invitees: params[:invitees]}
    ViewingParty.create_viewing_party_invitees(viewing_party.id, params[:invitees])
    if viewing_party.save
      render json: ViewingPartySerializer.format_viewing_party(viewing_party), status: :created
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    end
  end

  private

  def viewing_party_params
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title, :host)
  end

  def handle_missing_invitees(exception)
    render json: { error: exception.message }, status: 422
  end
end