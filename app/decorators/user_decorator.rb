class UserDecorator < ApplicationDecorator
  delegate_all

  decorates_association :auth_tokens

  ATTRS = %i[id email gender]

  private
  def _only
    ATTRS
  end

  def _methods
    if context[:brief]
      %i[full_name avatar_url age]
    else
      %i[avatar_url full_name birthdate coords tokens]
    end
  end

  def coords
    {
      lat: lat,

      lng: lng
    }
  end

  def birthdate
    birthday&.iso8601
  end

  def full_name
    "#{ first_name } #{ last_name }"
  end

  def avatar_url
    {
      original_url: model.avatar.url(:original),

      thumb_url: model.avatar.url(:thumb)
    }
  end

  def tokens
    auth_tokens
  end

  def age
    if birthday
      DateTime.now.year - birthday.year
    end
  end
end
