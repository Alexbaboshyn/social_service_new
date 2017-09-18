class Event < ApplicationRecord
  belongs_to :place

  has_and_belongs_to_many :users

  enum kind: [:free, :by_invitation, :friends_only]

  validates :kind, presence: true

  validates :start_time, presence: true

  validates :title, presence: true

  validates :place_id, presence: true

  validates :invites, presence: true, if: :kind_private?

  before_save :set_kind, on: :update

  def kind_private?
    self.kind == 'by_invitation'
  end

  def set_kind
    unless self.kind == 'by_invitation'
      self.invites = []
    end
  end
end
