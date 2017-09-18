require 'rails_helper'

RSpec.describe User, type: :model do
  it { should be_an ApplicationRecord }

  it { should have_secure_password }

  it { should define_enum_for(:gender).with([:male, :female]) }

  it { should have_many(:auth_tokens).dependent(:destroy) }

  it { should have_many(:places).through(:place_users) }

  it { should validate_presence_of :email }

  it { should validate_uniqueness_of(:email).case_insensitive }

  it { should_not allow_value('test').for(:email) }

  it { should allow_value('test@test.com').for(:email) }


  describe '#generate_auth_token' do
    let(:subject) { stub_model User }

    before do
      expect(subject).to receive(:auth_tokens) do
        double.tap { |a| expect(a).to receive(:create) }
      end
    end
    
    it { expect { subject.send :generate_auth_token }.to_not raise_error }
  end
end
