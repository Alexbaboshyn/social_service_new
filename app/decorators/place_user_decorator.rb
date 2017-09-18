class PlaceUserDecorator < ApplicationDecorator
  delegate_all

  decorates_association :place

  private
  def _only
    if context[:user]
      %I[rating]
    else
      []
    end
  end

  def _methods
    %I[place]
  end
end
