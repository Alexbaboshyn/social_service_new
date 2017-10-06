class Event < ApplicationRecord
  has_and_belongs_to_many :users

  has_many :invited, class_name: 'Invite', dependent: :destroy

  belongs_to :place

  enum kind: [:free, :by_invitation, :friends_only]

  validates :kind, :start_time, :title, :place_id,  presence: true

  validates :invites, presence: true, if: :kind_by_invitation?

  before_save :set_kind, on: :update

  after_save :build_invites, if: :kind_by_invitation?


  def kind_by_invitation?
    self.kind == 'by_invitation'
  end

  def set_kind
    unless self.kind == 'by_invitation'
      self.invites = []
      self.invited.delete_all
    end
  end

  def build_invites
    self.invites.each do |user_id|
      self.invited.find_or_create_by!(user_id: user_id)
    end
  end
end
