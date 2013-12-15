require 'spec_helper'

describe Category do

  let(:subject) { build :category, name: "Sample Category" }
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

end