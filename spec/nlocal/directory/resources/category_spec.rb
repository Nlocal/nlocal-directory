require 'spec_helper'
RSpec.describe Nlocal::Directory::Category do

  context "[Admin]" do
    before :all do
      test_user
      test_password

      VCR.use_cassette('token_create_ok') do
        RequestStore.store[:token] = Nlocal::Directory::Token.create
      end
    end

    describe :index do
      context 'categories' do
        use_vcr_cassette "categories_list"

        subject(:categories) {
          Nlocal::Directory::Category.all }

          it { expect(categories.size).to be >= 1 }
        end
    end

    describe :create do
      context "root category" do
        use_vcr_cassette "category_create"
        subject(:category){Nlocal::Directory::Category.create(name: "category_test")}

        it {expect(category).not_to be_empty}
        it {expect(category.id).not_to be_nil}
        it {expect(category.name).to eq("category_test")}
        it {expect(category.parent_id).to eq(nil)}
        it {expect(category.depth).to eq(0)}
        it {expect(category.children).to be_nil}
      end

      context "child category" do
        use_vcr_cassette "category_create"
        let(:parent){
          Nlocal::Directory::Category.create(name: "category_test")
        }
        subject(:category){Nlocal::Directory::Category.create(name: "child_category_test", parent_id: parent.id)}

        it {expect(category).not_to be_empty}
        it {expect(category.id).not_to be_nil}
        it {expect(category.name).to eq("child_category_test")}
        it {expect(category.parent_id).to eq(parent.id)}
        it {expect(category.depth).to eq(1)}
        it {expect(category.children).to be_nil}
      end
    end

    describe :show do
      context "root category" do
        let(:category_id){
          VCR.use_cassette("category_create") do
            Nlocal::Directory::Category.create(name:"category_test").id
          end
        }
        use_vcr_cassette "category_show"
        subject(:category){Nlocal::Directory::Category.find(category_id)}

        it {expect(category).not_to be_empty}
        it {expect(category.id).not_to be_nil}
        it {expect(category.name).to eq("category_test")}
        it {expect(category.parent_id).to eq(nil)}
        it {expect(category.depth).to eq(0)}
        it {expect(category.children.size).to eq(1)}
      end
    end

    describe :update do

      context "root category" do
        let(:category){
          VCR.use_cassette("category_create") do
            Nlocal::Directory::Category.create(name: "category_test")
          end
        }
        use_vcr_cassette "category_update"
        subject(:updated_category){ category.assign_attributes(name: "category_test_updated")
                                    category.save
                                  }

        it {expect(updated_category).not_to be_empty}
        it {expect(updated_category.id).not_to be_nil}
        it {expect(updated_category.name).to eq("category_test_updated")}
        it {expect(updated_category.parent_id).to eq(nil)}
        it {expect(updated_category.depth).to eq(0)}
      end
    end

    describe :delete do

      context "root category" do
        let(:category){
          VCR.use_cassette("category_create") do
            Nlocal::Directory::Category.create(name: "category_test")
          end
        }
        use_vcr_cassette "category_delete"
        subject(:destroyed_category){ category.destroy }

        it {expect(destroyed_category).not_to be_empty}
        it {expect(destroyed_category.id).to eq(category.id)}
      end

    end
  end
end
