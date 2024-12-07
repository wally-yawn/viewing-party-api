class Api::V1::ViewingPartiesController < ApplicationController

  def create
    viewing_party_params[:host] = params[:host_id]
    viewing_party = ViewingParty.create!(viewing_party_params)
    viewing_party_invitee_params = {viewing_party_id: viewing_party.id, invitees: params[:invitees]}
    if viewing_party.save
      render json: ViewingPartySerializer.new(viewing_party), status: :created
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    end
  end

  private

  def viewing_party_params
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title, :host)# :invitees)
  end
end