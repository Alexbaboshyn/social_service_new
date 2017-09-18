require 'rails_helper'

RSpec.describe Api::PlaceUsersController, type: :controller do
  it { should be_an ApplicationController }

  describe '#create' do
    let(:user) { stub_model User }

    let(:params) { { place_id: '1', place_user: { rating: '5' } } }

    let(:parent) { stub_model Place }

    let(:object) { stub_model PlaceUser }

    before { sign_in user }

    before { expect(Place).to receive(:find).with('1').and_return(parent) }

    before do
      expect(parent).to receive(:place_users) do
        double.tap { |a| expect(a).to receive(:build).with(permit!(rating: '5').merge(user: user)).and_return(object) }
      end
    end

    before { expect(object).to receive(:save!) }

    before { post :create, params: params, format: :json }

    it { should render_template :create }
  end
end
