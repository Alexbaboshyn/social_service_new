require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should be_an ApplicationRecord }

  describe '#kind_by_invitation?' do
    let(:subject) { stub_model Event }

    context do
      before do
        expect(subject).to receive(:kind) do
          double.tap { |a| expect(a).to receive(:==).with('by_invitation').and_return(false) }
        end
      end
    end

    context do
      before do
        expect(subject).to receive(:kind) do
          double.tap { |a| expect(a).to receive(:==).with('by_invitation').and_return(true) }
        end
      end
    end

    it { expect { subject.send :kind_by_invitation? }.to_not raise_error }
  end

  describe '#set_kind' do
    let(:subject) { stub_model Event, kind: 'free' }

    before do
      expect(subject).to receive(:invited) do
        double.tap { |a| expect(a).to receive(:delete_all) }
      end
    end

    before { expect(subject).to receive(:invites=).with([]) }

    it { expect { subject.send :set_kind }.to_not raise_error }
  end

  describe '#build_invites' do
    let(:subject) { stub_model Event }

    before { expect(subject).to receive(:invites).and_return([1]) }

    before do
      expect(subject).to receive(:invited) do
        double.tap { |a| expect(a).to receive(:find_or_create_by!).with(user_id: 1) }
      end
    end

    it { expect { subject.send :build_invites }.to_not raise_error }
  end
end
