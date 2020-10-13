require 'spec_helper'

RSpec.describe "IpsValidator::Loader"  do
  let(:status) { 'Implemented' }
  let(:ips){
    {
      "fip" => 7,
      "title" => 'Oracle Trading Locks',
      "author" => 'Jackson Chan, Kain Warwick, Clinton Ennis',
      "status" => status,
      "created" => Date.parse('2019-07-09')
    }
  }
  let(:file_name) {
   'spec/fixtures/valid/fip-7.md'
  }

  subject(:loader){ IpsValidator::Loader.load(file_name)}

  describe "valid" do
    it "should have required fields" do
      expect(loader).to eq(ips)
    end
  end
end