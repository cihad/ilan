require 'spec_helper'

describe Node do

  subject { build :node, title: "Example Title",
                         description: "Example description",
                         contact: "Example contact",
                         email: "example@example.com" }

  its(:title) { should eq "Example Title" }
  its(:description) { should eq "Example description" }
  its(:contact) { should eq "Example contact" }
  its(:email) { should eq "example@example.com" }
  it("with valid attributes should be valid") { should be_valid }

  %w(title description contact email).each do |attr|
    it "blank #{attr} is not valid" do
      subject.send("#{attr}=", "")
      subject.should_not be_valid
    end
  end

  describe "#email" do
    it do
      subject.email = "unvalid_email@example"
      subject.should_not be_valid
      expect(subject.errors.messages).to be_has_key :email
    end

    it do
      subject.email = "valid.email@example.com"
      subject.should be_valid
      expect(subject.errors.messages).not_to be_has_key :email
    end

    it do
      subject.email = "valid.email@example.info.tr"
      subject.should be_valid
      expect(subject.errors.messages).not_to be_has_key :email
    end
  end

  describe "#city" do
    it "is a City" do
      expect(subject.city).to be_a(City)
    end

    it "required" do
      subject.city = nil
      subject.should_not be_valid
    end
  end

  describe "#category" do
    it "is a Category" do
      expect(subject.category).to be_a(Category)
    end

    it "required" do
      subject.category = nil
      subject.should_not be_valid
    end
  end
  
end