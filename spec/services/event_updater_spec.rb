require 'rails_helper'

RSpec.describe EventUpdater do
  let(:event_updater) { EventUpdater.new params }

  let(:resource) { stub_model Event, invites: [1, 2] }

  let(:params) { { invites: '[1, 2, 3]', date: '2017-09-12', start_time: '17:00', resource: resource } }

  subject { event_updater }

  its(:resource) { should eq resource }
end
