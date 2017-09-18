require 'rails_helper'

RSpec.describe AuthTokenDecorator do
  describe '#as_json' do
    let(:auth_token) { stub_model AuthToken, value: '123456', expired_at: '2017-09-08' }

    subject { auth_token.decorate.as_json }

    its([:value]) { should eq '123456' }

    its([:expired_at]) { should eq '2017-09-08' }
  end
end
