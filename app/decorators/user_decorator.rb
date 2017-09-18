class UserDecorator < ApplicationDecorator
  delegate_all

  decorates_association :auth_tokens

  private
  def _only
    %I[id email gender]
  end

  def _methods
    if context[:brief]
      %I[full_name avatar_url age]
    else
      %I[avatar_url full_name birthdate coords tokens]
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
