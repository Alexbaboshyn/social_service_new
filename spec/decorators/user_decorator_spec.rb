require 'rails_helper'

RSpec.describe UserDecorator do

  let(:user) { stub_model User, id: 5,
                             email: 'test@test.com',
                            gender: 'male',
                        first_name: 'John',
                         last_name: 'Silver',
                          birthday: 2017-07-11,
                               lat: 48.1,
                               lng: 29.2 }

  describe '#as_json' do
    context '#brief' do
      subject { user.decorate(context: { brief: true }) }

      before { expect(subject).to receive(:full_name).and_return('John Silver') }

      before { expect(subject).to receive(:avatar_url).and_return({ original_url: "/avatars/original/missing.png", thumb_url: "/avatars/thumb/missing.png"}) }

      before { expect(subject).to receive(:age).and_return(10) }

      its('as_json.symbolize_keys') do

        should eq \
        id: 5,
        email: 'test@test.com',
        gender: 'male',
        full_name: 'John Silver',
        avatar_url: { original_url: "/avatars/original/missing.png", thumb_url: "/avatars/thumb/missing.png"},
        age: 10
      end
    end

    context do
      let(:auth_tokens) { stub_model AuthToken }

      subject { user.decorate }

      before { expect(subject).to receive(:full_name).and_return('John Silver') }

      before { expect(subject).to receive(:avatar_url).and_return({ original_url: "/avatars/original/missing.png", thumb_url: "/avatars/thumb/missing.png"}) }

      before { expect(subject).to receive(:birthdate).and_return(10) }

      before { expect(subject).to receive(:coords).and_return({lat: 48.1, lng: 29.2}) }

      before { expect(subject).to receive(:tokens).and_return(auth_tokens) }

      its('as_json.symbolize_keys') do

        should eq \
        id: 5,
        email: 'test@test.com',
        gender: 'male',
        full_name: 'John Silver',
        avatar_url: { original_url: "/avatars/original/missing.png", thumb_url: "/avatars/thumb/missing.png"},
        birthdate: 10,
        coords: {lat: 48.1, lng: 29.2},
        tokens: auth_tokens
      end
    end
  end


  # describe '#age' do
  #   subject { user.decorate }
  #
  #   before do
  #     expect(DateTime).to receive(:now) do
  #       double.tap do |a|
  #         expect(a).to receive(:year) do
  #           double.tap { |b| expect(b).to receive(:-).with(:birthday.year).and_return(10)}
  #         end
  #       end
  #     end
  #   end
  #
  #   before { subject.send :age }
  #
  #   its(:age) {should eq 10}
  # end

  describe '#birthdate' do
    subject { user.decorate }

    before do
      expect(subject).to receive(:birthday) do
        double.tap { |c| expect(c).to receive(:iso8601).and_return(2017) }
      end
    end

    its(:birthdate) { should eq 2017 }
  end

  describe '#tokens' do
    subject { user.decorate }

    let(:auth_tokens) { stub_model AuthToken }

    before { expect(subject).to receive(:auth_tokens).and_return(auth_tokens) }

    its(:tokens) { should eq auth_tokens }
  end


  describe '#coords' do
    subject { user.decorate }

    before { expect(subject).to receive(:lat).and_return(user.lat) }

    before { expect(subject).to receive(:lng).and_return(user.lng) }

    xit(:coords) { should eq ({lat: 48.1, lng: 29.2}) }
  end


end
