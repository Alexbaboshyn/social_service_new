require 'rails_helper'

RSpec.describe PlaceUserDecorator do

  let(:place_user) { stub_model PlaceUser, rating: 5 }

  let(:place) { stub_model Place }

  describe '#as_json' do
    context '#user' do
      subject { place_user.decorate(context: { user: true }) }

      before { expect(subject).to receive(:place).and_return place }

      its('as_json.symbolize_keys') do

        should eq \
        rating: 5,
        place: place.decorate
      end
    end

    context do
      subject { place_user.decorate }

      before { expect(subject).to receive(:place).and_return place }

      its('as_json.symbolize_keys') do

        should eq \
          place: place.decorate
      end
    end
  end
end
