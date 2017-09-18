RSpec.describe Api::UserRatingsController, type: :controller do
  it { should be_an ApplicationController }

  describe '#collection' do
    context 'user_id' do
      before { sign_in }

      before { expect(subject).to receive(:params).twice.and_return({ user_id: 1 }) }

      before { expect(PlaceUser).to receive(:where).with(user_id: 1).and_return(:collection) }

      its(:collection) { should eq :collection }
    end

    context 'place_id' do
      before { sign_in }

      before { expect(subject).to receive(:params).exactly(3).times.and_return({ place_id: 2 }) }

      before { expect(Place).to receive(:find).with(2).and_return(:collection) }

      its(:collection) { should eq :collection }
    end
  end

  describe '#index' do

    before { sign_in }

    before { process :index, method: :get, params: { user_id: 1 }, format: :json }

    it { should render_template :index }
  end
end
