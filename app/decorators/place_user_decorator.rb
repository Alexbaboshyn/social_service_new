class PlaceUserDecorator < ApplicationDecorator
  delegate_all

  decorates_association :place

  private
  def _only
    if context[:user]
      %i[rating]
    else
      []
    end
  end

  def _methods
    %i[place]
  end
end
