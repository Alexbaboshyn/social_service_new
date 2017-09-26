require 'rails_helper'

RSpec.describe EventDecorator do

  let(:event) { stub_model Event, id: 1,
                                kind: 'free',
                               title: 'Event',
                            place_id: 2,
                          start_time: '2017-09-20 17:00',
                           author_id: 3,
                             invites: [1]}

  # describe '#as_json' do
  #   subject { event.decorate }
  #
  #   # before { expect(subject).to receive(:coords).and_return({lat: 48.1, lng: 29.2}) }
  #   #
  #   # before { expect(subject).to receive(:distance).and_return(1000) }
  #     its('as_json.symbolize_keys') do
  #
  #       should eq \
  #       id: 1,
  #       kind: 'free',
  #       title: 'Event'
  #       # place: ['burgers', 'cola'],
  #       # date: 'New York',
  #       # time: 5.0,
  #       # author: {lat: 48.1, lng: 29.2},
  #       # people_attended_count: 1000,
  #       # people_attended: ,
  #       # invited:
  #     end
  #   end

  describe '#place' do
    subject { event.decorate }

    let(:place) { stub_model Place }

    before do
      expect(Place).to receive(:find).with(2) do
        double.tap { |a| expect(a).to receive(:decorate).with(context: { short: true }).and_return(place) }
      end
    end
    its(:place) { should eq place }
  end

  describe '#date' do
    subject { event.decorate }

    before do
      expect(subject).to receive(:start_time) do
        double.tap { |a| expect(a).to receive(:to_date).and_return('2017-09-20') }
      end
    end
    its(:date) { should eq '2017-09-20' }
  end

  describe '#time' do
    subject { event.decorate }

    before do
      expect(subject).to receive(:start_time) do
        double.tap { |a| expect(a).to receive(:strftime).with("%H:%M").and_return('17:00') }
      end
    end
    its(:time) { should eq '17:00' }
  end

  describe '#author' do
    subject { event.decorate }

    let(:author) { stub_model User }

    before do
      expect(User).to receive(:find).with(3) do
        double.tap { |a| expect(a).to receive(:decorate).with(context: { brief: true }).and_return(author) }
      end
    end
    its(:author) { should eq author }
  end

  describe '#people_attended_count' do
    subject { event.decorate }

    before do
      expect(subject).to receive(:users) do
        double.tap { |a| expect(a).to receive(:count).and_return(1) }
      end
    end
    its(:people_attended_count) { should eq 1 }
  end

  describe '#invited' do
    subject { event.decorate }

    let(:user) { stub_model User }

    before  do
      expect(User).to receive(:joins).with(:invites) do
        double.tap do |a|
          expect(a).to receive(:where).with(invites:{ event_id: 1}) do
            double.tap { |b| expect(b).to receive(:decorate).with(context: { brief: true }).and_return(user) }
          end
        end
      end
    end

    its(:invited) { should eq user }
  end

  describe '#people_attended' do
    subject { event.decorate }

    let(:user) { stub_model User }

    before do
      expect(subject).to receive(:users) do
        double.tap { |a| expect(a).to receive(:decorate).with(context: { brief: true }).and_return(user) }
      end
    end
    its(:people_attended) { should eq user }
  end
end
