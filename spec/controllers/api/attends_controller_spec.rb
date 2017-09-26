require 'rails_helper'

RSpec.describe Api::AttendsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#create' do
    let(:user) { stub_model User }

    let(:parent) { stub_model Event }

    let(:params) { { event_id: '1' } }

    before { sign_in user }

    before { expect(Event).to receive(:find).with('1').and_return(parent) }

    before do
      expect(parent).to receive(:users) do
        double.tap { |a| expect(a).to receive(:<<).with(user) }
      end
    end

    before { process :create, method: :post, params: params, format: :json }

    it { expect(response).to have_http_status(:ok) }
  end


  describe '#destroy' do
    let(:user) { stub_model User }

    let(:user1) { stub_model User }

    let(:params) { { event_id: '1', id: '2' } }

    let(:event) { stub_model Event }

    before { sign_in user}

    before do
      expect(user).to receive(:own_events) do
        double.tap { |a| expect(a).to receive(:find).with('1').and_return(event) }
      end
    end

    before { expect(User).to receive(:find).with('2').and_return(user1) }

    before do
      expect(event).to receive(:users) do
        double.tap { |a| expect(a).to receive(:delete).with(user1) }
      end
    end

    before { process :destroy, method: :delete, params: params, format: :json }

    it { expect(response).to have_http_status(204) }
  end
end
