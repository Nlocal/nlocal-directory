describe User do
  before do
    stub_api_for(User) do |stub|
      stub.get("/users/popular") { |env| [200, {}, [{ id: 1, name: "Tobias Fünke" }, { id: 2, name: "Lindsay Fünke" }].to_json] }
    end
  end

  describe :popular do
    subject { User.popular }
    its(:length) { should == 2 }
    its(:errors) { should be_empty }
  end
end
