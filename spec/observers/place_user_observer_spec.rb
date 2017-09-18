require 'rails_helper'

RSpec.describe PlaceUserObserver, type: :observer do
  let(:place_user) { stub_model PlaceUser, place_id: 1 }

  subject { described_class.send(:new) }

  describe '#after_create' do
    before do
      expect(PlaceUser).to receive(:where).with(place_id: place_user.place_id) do
        double.tap { |a| expect(a).to receive(:average).with(:rating).and_return 5}
      end
    end

    before do
      expect(Place).to receive(:find_by).with(id: place_user.place_id) do
        double.tap { |a| expect(a).to receive(:update_attribute).with(:overall_rating, 5) }
      end
    end

    it { expect { subject.after_create(place_user) }.to_not raise_error }
  end
end
