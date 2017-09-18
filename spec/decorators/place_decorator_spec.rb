require 'rails_helper'

RSpec.describe PlaceDecorator do

  let(:place) { stub_model Place, id: 1,
                                name: 'Burger King',
                            place_id: "1",
                                tags: ['burgers', 'cola'],
                                city: 'New York',
                      overall_rating: 5.0,
                              lat: 48.1,
                              lng: 29.2 }

  describe '#as_json' do
    context do
      let(:ratings) { stub_model PlaceUser }

      subject { place.decorate(context: { place: true }) }

      subject { place.decorate }

      before { expect(subject).to receive(:coords).and_return({lat: 48.1, lng: 29.2}) }

      before { expect(subject).to receive(:distance).and_return(1000) }

      # before { expect(subject).to receive(:ratings).and_return(ratings) }

      its('as_json.symbolize_keys') do

        should eq \
        id: 1,
        name: 'Burger King',
        place_id: "1",
        tags: ['burgers', 'cola'],
        city: 'New York',
        overall_rating: 5.0,
        coords: {lat: 48.1, lng: 29.2},
        distance: 1000
        # ratings: ratings
      end
    end


    context do
      subject { place.decorate }

      before { expect(subject).to receive(:coords).and_return({lat: 48.1, lng: 29.2}) }

      before { expect(subject).to receive(:distance).and_return(1000) }

      its('as_json.symbolize_keys') do

        should eq \
        id: 1,
        name: 'Burger King',
        place_id: "1",
        tags: ['burgers', 'cola'],
        city: 'New York',
        overall_rating: 5.0,
        coords: {lat: 48.1, lng: 29.2},
        distance: 1000
      end
    end
  end


  describe '#coords' do
    subject { place.decorate }

    before { expect(subject).to receive(:lat).and_return(place.lat) }

    before { expect(subject).to receive(:lng).and_return(place.lng) }

    its(:coords) { should eq ({lat: 48.1, lng: 29.2}) }
  end


end
