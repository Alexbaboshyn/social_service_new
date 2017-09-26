require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#create' do
    let(:params) { { event: { place_id: '1', kind: 'free', start_time: '2017-09-25', title: 'Title' } } }

    let(:user) { stub_model User }

    let(:event) { stub_model Event }

    before { sign_in user }

    before { expect(Event).to receive(:new).with(permit!(place_id: '1', kind: 'free', start_time: '2017-09-25', title: 'Title').merge(author_id: user.id)).and_return(event) }

    before { expect(event).to receive(:save!) }

    before { process :create, method: :post, params: params, format: :json }

    it { should render_template :create }
  end

  describe '#update' do
    let(:params) { { id: '2', event: { kind: 'free', title: 'Title' } } }

    let(:resource) { stub_model Event }

    let(:event) { stub_model Event }

    let(:user) { stub_model User }

    before { sign_in user}

    before do
      expect(user).to receive(:own_events) do
        double.tap { |a| expect(a).to receive(:find).with('2').and_return(resource) }
      end
    end

    before do
      expect(EventUpdater).to receive(:new).with(permit!(kind: 'free', title: 'Title').merge(resource: resource)) do
        double.tap { |a| expect(a).to receive(:update).and_return(event) }
      end
    end

    before { expect(event).to receive(:save!) }

    before { process :update, method: :patch, params: params, format: :json }

    it { should render_template :update }
  end

  describe '#collection' do

    context 'params[:place_id]' do
      before { sign_in}

      before { expect(subject).to receive(:params).twice.and_return(place_id: 1) }

      before { expect(Event).to receive(:where).with(place_id: 1).and_return(:events) }

      its(:collection) { should eq :events }
    end

    context do
      let(:user) { stub_model User }

      before { sign_in user}

      before do
        expect(EventSearcher).to receive(:new).with(user: user) do
          double.tap { |a| expect(a).to receive(:search).and_return(:events) }
        end
      end
      its(:collection) { should eq :events }
    end
  end
end
