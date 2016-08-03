require 'spec_helper'
describe Nlocal::Directory::User do
  before do
    RequestStore[:token]= Nlocal::Directory::Token.create(email: "daniel.prado@nlocal.com", password: "prueba327")
  end

  describe :index do
    context 'get all' do
      use_vcr_cassette "users_list"
      subject { Nlocal::Directory::User.all }

      it { expect(subject.size).to be > 1 }
    end
  end
end
