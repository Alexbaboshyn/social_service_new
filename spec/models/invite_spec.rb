require 'rails_helper'

RSpec.describe Invite, type: :model do
  it { should be_an ApplicationRecord }

  it { should belong_to :user }

  it { should belong_to :event }  
end
