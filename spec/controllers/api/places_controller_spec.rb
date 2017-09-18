require 'rails_helper'

RSpec.describe Api::PlacesController, type: :controller do
  it { should be_an ApplicationController }

  describe '#index' do
    let(:user) { stub_model User }

    before { sign_in user }

    before { process :index, method: :get, format: :json }

    it { should render_template :index }
  end

  describe '#show' do
    let(:user) { stub_model User }

    before { sign_in user }

    before { process :show, method: :get, params: {id: 1}, format: :json }

    it { should render_template :show }
  end

  describe '#resource' do
    before { expect(subject).to receive(:params).and_return({ id: 1 }) }

    before { expect(Place).to receive(:find).with(1).and_return(:resource) }

    its(:resource) { should eq :resource }
  end

  describe '#collection' do
    let(:user) { stub_model User }

    let(:place_searcher) { double }

    before { sign_in user }

    before { expect(subject).to receive(:params).and_return({ city: 'Vinnytsia' }) }

    before { expect(PlaceSearcher).to receive(:new).with(city: 'Vinnytsia', current_user: user).and_return(place_searcher) }

    before do
      expect(place_searcher).to receive(:search) do
        double.tap { |a| expect(a).to receive(:order_by_distance).with(user.lat, user.lng).and_return(:collection) }
      end
    end
  
    its(:collection) { should eq :collection }
  end
end
