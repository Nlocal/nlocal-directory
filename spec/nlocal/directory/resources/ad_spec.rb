require 'spec_helper'
RSpec.describe Nlocal::Directory::Ad do

 context "admin user" do
   before :all do
     test_user
     test_password

     VCR.use_cassette('token_create_ok') do
       RequestStore.store[:token] = Nlocal::Directory::Token.create
     end

     VCR.use_cassette('user_create') do
       @advertiser= Nlocal::Directory::User.create(email:"ad_test_advertiser@test.com",
                                                   password: "ad_test_advertiser",
                                                   username: "ad_test_advertiser",
                                                   first_name: "advertiser",
                                                   last_name: "ad_test",
                                                   type: "Advertiser")
     end
   end

   after :all do
     VCR.use_cassette('user_delete') do
       @advertiser.destroy
     end
   end

   describe :index do
     context 'get all' do
       use_vcr_cassette "ads_list"

       subject(:ads) {
         Nlocal::Directory::Ad.all }

       it { expect(ads.size).to be > 1 }
     end
   end

   describe :create do
     context "create ad" do
       use_vcr_cassette "ad_create"
       subject(:ad){Nlocal::Directory::Ad.create(title: "ad_test", advertiser_id: @advertiser.id)}

       it {expect(ad).not_to be_empty}
       it {expect(ad.id).not_to be_nil}
       it {expect(ad.title).to eq("ad_test")}
       it {expect(ad.advertiser_id).to eq(@advertiser.id)}
     end
   end

   describe :show do
     context "get ad" do
       let(:ad_id){
         VCR.use_cassette("ad_create") do
           Nlocal::Directory::Ad.create(title: "ad_test", advertiser_id: @advertiser.id).id
         end
       }
       use_vcr_cassette "ad_show"
       subject(:ad){Nlocal::Directory::Ad.find(ad_id)}

       it {expect(ad).not_to be_empty}
       it {expect(ad.id).not_to be_nil}
       it {expect(ad.title).to eq("ad_test")}
       it {expect(ad.advertiser_id).to eq(@advertiser.id)}

     end
   end

   describe :update do

     context "update ad" do
       let(:ad){
         VCR.use_cassette("ad_create") do
           Nlocal::Directory::Ad.create(title: "ad_test", advertiser_id: @advertiser.id)
         end
       }
       use_vcr_cassette "ad_update"
       subject(:updated_ad){ ad.assign_attributes(title: "ad_test_updated")
                             ad.save
                           }
       it {expect(updated_ad).not_to be_empty}
       it {expect(updated_ad.id).to eq(ad.id)}
       it {expect(updated_ad.title).to eq("ad_test_updated")}
     end
   end

   describe :delete do

     context "ad delete" do
       let(:ad){
         VCR.use_cassette("ad_create") do
           Nlocal::Directory::Ad.create(title: "ad_test", advertiser_id: @advertiser.id)
         end
       }
       use_vcr_cassette "ad_delete"
       subject(:destroyed_ad){
                               ad.destroy
                             }
       it {expect(destroyed_ad).not_to be_empty}
       it {expect(destroyed_ad.id).to eq(ad.id)}
     end

   end
 end

 
end
