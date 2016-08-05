require 'spec_helper'
RSpec.describe Nlocal::Directory::Token do
  before :all do
    test_user
    test_password
  end

  describe :create do
    context 'ok' do
      use_vcr_cassette "token_create_ok"
      subject{ Nlocal::Directory::Token.create }
      it { expect(subject.access_token).not_to be_empty }
    end
  end
end
