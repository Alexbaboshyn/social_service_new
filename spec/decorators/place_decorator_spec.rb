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
      # let(:value) { stub_model double }

      subject { place.decorate(context: { place: true }) }

      subject { place.decorate }

      before { expect(subject).to receive(:coords).and_return({lat: 48.1, lng: 29.2}) }

      before { expect(subject).to receive(:distance).and_return(1000) }

      # before { expect(subject).to receive(:ratings).and_return(value) }

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
        # ratings: value
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

    its(:coords) { should eq ({lat: 48.1, lng: 29.2}) }
  end

  describe '#distance' do
    subject { place.decorate }

    before  do
      expect(subject).to receive(:h) do
        double.tap do |a|
          expect(a).to receive(:current_user) do
            double.tap { |b| expect(b).to receive(:distance_to_place).with(place).and_return(100) }
          end
        end
      end
    end

    its(:distance) { should eq 100 }
  end

  describe '#ratings' do
    subject { place.decorate }

    let(:place_user) { stub_model PlaceUser, rating: 5 }

    let(:user) { stub_model User }

    before { expect(subject).to receive(:place_users).and_return([place_user]) }

    before do
      expect(place_user).to receive(:user) do
        double.tap { |a| expect(a).to receive(:decorate).with(context: { brief: true }).and_return(user) }
      end
    end

    its(:ratings) { should eq ([{user: user, rating: 5}]) }
  end
end
