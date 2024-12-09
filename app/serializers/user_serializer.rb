class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :username, :api_key

  def self.format_user_list(users)
    { data:
        users.map do |user|
          {
            id: user.id.to_s,
            type: "user",
            attributes: {
              name: user.name,
              username: user.username
            }
          }
        end
    }
  end

  def self.format_user_profile(user)
    viewing_parties_hosted = user.viewing_partys.where(host: user.id)
    viewing_parties_invited = user.viewing_partys.where.not(host: user.id)
    { data:
      {
        id: user.id,
        type: "user",
        attributes: {
          name: user.name,
          username: user.username,
          viewing_parties_hosted: viewing_parties_hosted.map do |viewing_party|
            ViewingPartySerializer.format_viewing_party_for_user_profile_hosted(viewing_party)
          end,
          viewing_parties_invited: viewing_parties_invited.map do |viewing_party|
          ViewingPartySerializer.format_viewing_party_for_user_profile_invited(viewing_party)
          end
        }
      }
    }
  end
end