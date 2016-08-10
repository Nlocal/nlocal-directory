require 'spec_helper'
RSpec.describe Nlocal::Directory::User do

  before :all do
    test_user
    test_password
  end

  before :each do
    VCR.use_cassette('token_create_ok') do
      RequestStore.store[:token] = Nlocal::Directory::Token.create
    end
  end

  describe :index do
    context 'users' do
      use_vcr_cassette "users_list"

      subject(:users) {
        Nlocal::Directory::User.all }

      it { expect(users.size).to be > 1 }
    end
  end

  describe :create do
    context "agency" do
      use_vcr_cassette "user_create"
      subject(:agency){ RequestStore.store[:agency]= Nlocal::Directory::User.create(email:"agency@test.com",
                                              password: "agency_test",
                                              username: "agency_test",
                                              first_name: "agency",
                                              last_name: "test",
                                              type: "Agency")
                       }

      it {expect(agency).not_to be_empty}
      it {expect(agency.id).not_to be_nil}
      it {expect(agency.email).to eq("agency@test.com")}
      it {expect(agency.password).to eq("agency_test")}
      it {expect(agency.username).to eq("agency_test")}
      it {expect(agency.first_name).to eq("agency")}
      it {expect(agency.last_name).to eq("test")}
    end

    context "advertiser as agency" do
      let(:agency){
        RequestStore.store[:agency]
      }
      let(:token){
        VCR.use_cassette('token_create_ok') do
          Nlocal::Directory::Token.create(email: agency.email, password: agency.password)
        end
      }
      use_vcr_cassette "user_create"
      subject(:advertiser){
                             RequestStore.store[:token]= token
                             RequestStore.store[:advertiser]= Nlocal::Directory::User.create(email:"advertiser@test.com",
                                                                                             password: "advertiser_test",
                                                                                             username: "advertiser_test",
                                                                                             first_name: "advertiser",
                                                                                             last_name: "test",
                                                                                             type: "Advertiser")
                           }
      it {expect(advertiser).not_to be_empty}
      it {expect(advertiser.id).not_to be_nil}
      it {expect(advertiser.email).to eq("advertiser@test.com")}
      it {expect(advertiser.password).to eq("advertiser_test")}
      it {expect(advertiser.username).to eq("advertiser_test")}
      it {expect(advertiser.first_name).to eq("advertiser")}
      it {expect(advertiser.last_name).to eq("test")}
    end

  end

  describe :show do
    context "agency" do
      use_vcr_cassette "user_show"
      subject(:agency){
        Nlocal::Directory::User.find(RequestStore.store[:agency].id) }

      it {expect(agency).not_to be_empty}
      it {expect(agency.id).not_to be_nil}
      it {expect(agency.email).to eq("agency@test.com")}
      it {expect(agency.username).to eq("agency_test")}
      it {expect(agency.first_name).to eq("agency")}
      it {expect(agency.last_name).to eq("test")}
    end

    context "advertiser as agency" do
      let(:agency){
        RequestStore.store[:agency]
      }
      let(:token){
        VCR.use_cassette('token_create_ok') do
          Nlocal::Directory::Token.create(email: agency.email, password: agency.password)
        end
      }
      use_vcr_cassette "user_show"
      subject(:advertiser){
                            RequestStore.store[:token]= token
                            Nlocal::Directory::User.find(RequestStore.store[:advertiser].id)
                          }

      it {expect(advertiser).not_to be_empty}
      it {expect(advertiser.id).not_to be_nil}
      it {expect(advertiser.email).to eq("advertiser@test.com")}
      it {expect(advertiser.username).to eq("advertiser_test")}
      it {expect(advertiser.first_name).to eq("advertiser")}
      it {expect(advertiser.last_name).to eq("test")}
    end
  end

  describe :update do

    context "agency" do
      let(:agency) {
        RequestStore.store[:agency]
      }
      use_vcr_cassette "user_update"
      subject(:updated_agency){ agency.assign_attributes(first_name: "test",
                                       last_name: "agency")
                                agency.save
                              }
      it {expect(updated_agency).not_to be_empty}
      it {expect(updated_agency.id).not_to be_nil}
      it {expect(updated_agency.first_name).to eq("test")}
      it {expect(updated_agency.last_name).to eq("agency")}
    end

    context "advertiser as agency" do
      let(:agency){
        RequestStore.store[:agency]
      }
      let(:token){
        VCR.use_cassette('token_create_ok') do
          Nlocal::Directory::Token.create(email: agency.email, password: agency.password)
        end
      }
      let(:advertiser){
        RequestStore.store[:advertiser]
      }
      use_vcr_cassette "user_update"
      subject(:updated_advertiser){
                                RequestStore.store[:token]= token
                                advertiser.assign_attributes(first_name: "test",
                                                             last_name: "advertiser")
                                advertiser.save
                              }
      it {expect(updated_advertiser).not_to be_empty}
      it {expect(updated_advertiser.id).not_to be_nil}
      it {expect(updated_advertiser.first_name).to eq("test")}
      it {expect(updated_advertiser.last_name).to eq("advertiser")}
    end
  end

  describe :delete do

    context "advertiser as agency" do
      let(:agency){
        RequestStore.store[:agency]
      }
      let(:token){
        VCR.use_cassette('token_create_ok') do
          Nlocal::Directory::Token.create(email: agency.email, password: agency.password)
        end
      }
      let(:advertiser){
        RequestStore.store[:advertiser]
      }
      use_vcr_cassette "user_delete"
      subject(:destroyed_advertiser){
                                      RequestStore.store[:token]= token
                                      advertiser.destroy
                                     }
      it {expect(destroyed_advertiser).not_to be_empty}
      it {expect(destroyed_advertiser.id).not_to be_nil}
    end

    context "agency" do
      let(:agency){
        RequestStore.store[:agency]
      }
      use_vcr_cassette "user_delete"
      subject(:destroyed_agency){ agency.destroy }

      it {expect(destroyed_agency).not_to be_empty}
      it {expect(destroyed_agency.id).not_to be_nil}
    end
  end


end
