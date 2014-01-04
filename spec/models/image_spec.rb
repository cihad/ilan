require 'spec_helper'

describe Image do
  subject { build :image }

  it { should be_respond_to :image }
  it { should be_respond_to :node }

  it "requires image" do
    subject.image = nil
    expect(subject).to_not be_valid
  end

  it "attachments image" do
    expect(subject.dragonfly_attachments).to include(:image)
  end

  describe "node" do
    it "is required" do
      subject.node = nil
      expect(subject).to_not be_valid
    end
  end
end
