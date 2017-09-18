require 'rails_helper'

RSpec.describe AuthToken, type: :model do
  it { should be_an ApplicationRecord }

  it { should belong_to :user }  

  it { should validate_uniqueness_of :value }

  it { is_expected.to callback(:set_value).before(:save) }

  it { is_expected.to callback(:set_expiration_date).before(:save) }


  describe '#set_value' do
    let(:subject) { stub_model AuthToken }

    before { expect(SecureRandom).to receive(:uuid).and_return('token') }

    before { subject.send :set_value }

    its(:value) { should eq 'token' }
  end


  describe '#set_expiration_date' do
    let(:subject) { stub_model AuthToken }

    let(:date) { double }

    before { expect(DateTime).to receive(:now).and_return(date) }

    before { expect(date).to receive(:+).with(2.weeks).and_return('2017-09-05') }

    before { subject.send :set_expiration_date }

    its(:expired_at) { should eq '2017-09-05' }
  end
end
