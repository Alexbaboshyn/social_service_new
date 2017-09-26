require 'rails_helper'

RSpec.describe PlaceSearcher do
  let(:current_user) { stub_model User, lat: 40.58, lng: 29.10 }

  let(:params) { { city: 'city', tags: 'pub', range: 10, current_user: current_user } }

  let(:place_searcher) { PlaceSearcher.new params }

  subject { place_searcher }

  its(:city) { should eq 'city' }

  its(:tags) { should eq 'pub' }

  its(:range) { should eq 10 }

  
  describe '#search' do
    let(:places) { stub_model Place }

    before { expect(subject.city).to receive(:capitalize).and_return('City') }

    before do
      expect(Place).to receive(:where).with('earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(places.lat, places.lng)', current_user.lat, current_user.lng, 10) do
        double.tap do |a|
          expect(a).to receive(:where).with(city: 'City') do
            double.tap { |b| expect(b).to receive(:where).with("'#{ subject.tags }' = ANY (tags)").and_return(places) }
          end
        end
      end
    end
    its(:search) { should eq places }
  end
end
