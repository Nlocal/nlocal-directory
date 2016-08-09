require 'spec_helper'
RSpec.describe Nlocal::Directory::User do
  before :all do
    test_user
    test_password
    VCR.use_cassette('token_create_ok') do
      RequestStore.store[:token]||= Nlocal::Directory::Token.create
    end
  end

  describe :index do
    context 'get all' do
      use_vcr_cassette "users_list"

      subject {
        Nlocal::Directory::User.all }

      it { expect(subject.size).to be > 1 }
    end
  end

  describe :create do
    context "create agency" do
      use_vcr_cassette "agency_create"
      subject{ RequestStore.store[:data]= Nlocal::Directory::User.create(email:"agency@test.com",
                                              password: "agency_test",
                                              username: "agency_test",
                                              first_name: "agency",
                                              last_name: "test",
                                              type: "Agency")
             }

      it {expect(subject).not_to be_empty}
      it {expect(subject.id).not_to be_nil}
      it {expect(subject.email).to eq("agency@test.com")}
      it {expect(subject.password).to eq("agency_test")}
      it {expect(subject.username).to eq("agency_test")}
      it {expect(subject.first_name).to eq("agency")}
      it {expect(subject.last_name).to eq("test")}
    end
  end

  describe :show do
    context "get user" do
      use_vcr_cassette "user_show"
      subject{
        Nlocal::Directory::User.find(RequestStore.store[:data].id) }

      it {expect(subject).not_to be_empty}
      it {expect(subject.id).not_to be_nil}
    end
  end

  describe :update do
    before :context do
      VCR.use_cassette('user_show') do
        @user= Nlocal::Directory::User.find(RequestStore.store[:data].id)
      end
    end
    context "update user" do
      use_vcr_cassette "user_update"
      subject{ @user.assign_attributes(first_name: "test",
                                       last_name: "agency")
               @user.save
             }
      it {expect(subject).not_to be_empty}
      it {expect(subject.id).not_to be_nil}
      it {expect(subject.first_name).to eq("test")}
      it {expect(subject.last_name).to eq("agency")}
    end
  end

  describe :delete do
    before :context do
      VCR.use_cassette('user_show') do
        @user= Nlocal::Directory::User.find(RequestStore.store[:data].id)
      end
    end
    context "delete_user" do
      use_vcr_cassette "user_delete"
      subject{ @user.destroy }

      it {expect(subject).not_to be_empty}
      it {expect(subject.id).not_to be_nil}
    end
  end


end
