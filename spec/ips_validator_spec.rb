RSpec.describe IpsValidator do
  it "has a version number" do
    expect(IpsValidator::VERSION).not_to be nil
  end

  it "raises exception if it includes invalid ips" do
    expect{
      IpsValidator::Runner.run Dir["spec/fixtures/valid/*md"]
    }.not_to raise_error
  end

  it "raises exception if it includes invalid ips" do
    expect{
      IpsValidator::Runner.run Dir["spec/fixtures/invalid/*md"]
    }.to raise_error
  end
end
