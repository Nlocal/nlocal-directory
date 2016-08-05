require 'spec_helper'
RSpec.describe Nlocal::Directory::User do
  before :all do
    test_user
    test_password
    RequestStore.store[:token]= Nlocal::Directory::Token.create
  end

  describe :index do
    context 'get all' do
      use_vcr_cassette "users_list"
      subject { Nlocal::Directory::User.all }

      it { expect(subject.size).to be > 1 }
    end
  end
end
