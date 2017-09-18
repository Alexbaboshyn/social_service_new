require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe '#authenticate' do
    # let(:date) { double }

    before { expect(subject).to receive(:authenticate_or_request_with_http_token).and_yield('token', nil) }

    before do
      #
      # User.joins(:auth_token).find_by(auth_tokens: { value: 'token', expired_at: DateTime.now..(DateTime.now + 2.weeks) })
      #
      expect(User).to receive(:joins).with(:auth_tokens) do
        double.tap do |a|
          expect(a).to receive(:find_by).with(auth_tokens: { value: 'token' })
        end
      end
    end

    it { expect { subject.send :authenticate }.to_not raise_error }
  end
end
