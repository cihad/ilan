require 'spec_helper'

describe Category do

  let(:subject) { build :category, name: "Sample Category", icon: "nice-icon" }
  its(:name) { should eq("Sample Category") }

  it "name is required" do
    subject.name = ""
    expect { subject.save }.to_not change(Category, :count)
    expect(subject.errors.keys).to include(:name)
  end

  it "name is uniq" do
    category1 = create :category, name: "Sample"
    category2 = build :category, name: "Sample"
    expect { category2.save }.to_not change(Category, :count)
    expect(category2.errors.keys).to include(:name)
  end

  describe "icon" do
    its(:icon) { should eq("nice-icon") }

    it "has default value" do
      subject.icon = ""
      subject.save
      expect(subject.icon).to eq("bullhorn")
    end
  end
end