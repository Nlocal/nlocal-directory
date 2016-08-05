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

  describe :show do
    context "get user" do
      use_vcr_cassette "user_show"
      subject{ Nlocal::Directory::User.find(29) }

      it {expect(subject).not_to be_empty}
    end
  end

  describe :update do
    before :context do
      @user= Nlocal::Directory::User.find(29)
    end
    context "update user" do
      use_vcr_cassette "user_update"
      
    end
  end


end
