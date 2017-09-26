require 'rails_helper'

RSpec.describe EventSearcher do
  let(:user) { stub_model User, lat: 40.58, lng: 29.10 }

  let(:event_searcher) { EventSearcher.new params }

  let(:params) { { start_date: '2017-09-10', end_date: '2017-09-12', range: 10, user: user } }

  subject { event_searcher }

  its(:start_date) { should eq '2017-09-10' }

  its(:end_date) { should eq '2017-09-12' }

  its(:range) { should eq 10 }


  describe '#search' do
    let(:events) { stub_model Event }

    before do
      expect(Event).to receive(:joins).with(:place) do
        double.tap do |a|
          expect(a).to receive(:where).with('earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(places.lat, places.lng)', user.lat, user.lng, 10) do
            double.tap { |b| expect(b).to receive(:where).with(:start_time => subject.start_date..subject.end_date).and_return(events) }
          end
        end
      end
    end
    its(:search) { should eq events }
  end
end
