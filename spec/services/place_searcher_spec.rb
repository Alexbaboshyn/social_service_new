require 'rails_helper'

RSpec.describe PlaceSearcher do
  let(:user) { stub_model User }

  let(:place_searcher) { PlaceSearcher.new city: 'City', tags: 'pub', range: 10 }

  subject { place_searcher }

  its(:city) { should eq 'City' }

  its(:tags) { should eq 'pub' }

  its(:range) { should eq 10 }

  # its(:current_user) { should eq user }

  # describe '#search' do
  #   let(:places) { double }
  #
  #   before { expect(Place).to receive(:within_radius).with(place_searcher.range, user.lat, user.lng).and_return(places) }
  #
  #     #
  #   # context do
  #   #
  #   #   before { expect(places).to receive(:where).with(city: place_searcher.city) }
  #   #
  #     it { expect { subject.send(:search).with(range: 10) }.to_not raise_error }
  #   # end
  #
  #  
  # end


end
