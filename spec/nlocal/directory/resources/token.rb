describe Token do
  before do
    stub_api_for(Token) do |stub|
      stub.get("/users/popular")
    end
  end

  describe :create do
    subject {Token.create(email: "daniel.prado@nlocal.com", password: "prueba327")}
    its(:errors) { should be_empty }
  end
end
