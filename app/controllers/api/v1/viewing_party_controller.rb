class API::V1::ViewingPartyController < ApplicationController
  def create
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.save
      render json: ViewingPartySerializer.new(viewing_party), status: :created
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new(user.errors.full_messages.to_sentence, 400)), status: :bad_request
    end
  end

  private

  def viewing_party_params
    params.permit(:name, :start_time, :end_time, :movie_id, :movie_title, :invitees)
  end
end