require 'spec_helper'

describe City do

  subject { build :city, name: "Ankara" }

  its(:name) { should eq "Ankara" }
  it("with valid attrs should be valid") { should be_valid }

  it "creates a new record" do
    expect { subject.save }.to change(City, :count).by(1)
  end

  it "name is required" do
    subject.name = ""
    subject.should_not be_valid
  end

end