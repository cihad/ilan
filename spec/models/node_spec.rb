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

  it "default scope" do
    node1 = create :node, updated_at: 2.day.ago
    node2 = create :node, updated_at: 1.day.ago

    expect(Node.all).to eq([node2, node1])
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

  describe "workflow" do
    before do
      subject.save
    end

    it "is pending approval after create" do
      subject.should be_pending_approval
    end

    it "is published after accept" do
      subject.publish!
      subject.should be_published
    end

    it "is rejected after reject" do
      subject.reject!
      subject.should be_rejected
    end

    it "is expired after expire" do
      subject.publish!
      subject.expire!
      subject.should be_expired
    end
  end

  describe "sends mail to user about node status" do
    before do
      subject.save
    end

    let(:last_mail_subject) { ActionMailer::Base.deliveries.last.subject }

    def mail_subject m
      I18n.t("node_status_mailer.#{m}.subject")
    end

    it "sends an email to user after published" do
      subject.publish!
      last_mail_subject.should eq(mail_subject('published'))
    end

    it "sends an email to user after rejected" do
      subject.reject!
      last_mail_subject.should eq(mail_subject('rejected'))
    end

    it "sends an email to user after expired" do
      subject.publish!
      subject.expire!
      last_mail_subject.should eq(mail_subject('expired'))
    end
  end

  it "#published" do
    expect {
      create :published_node
    }.to change(Node.published, :count).by(1)
  end

  it ".group_by_category" do
    city1 = create :city
    city2 = create :city

    category1 = create :category
    category2 = create :category
    category3 = create :category

    node1 = create :node,           city: city1, category: category1
    node2 = create :published_node, city: city1, category: category2
    node3 = create :published_node, city: city1, category: category3, updated_at: 2.day.ago
    node4 = create :published_node, city: city1, category: category3, updated_at: 1.day.ago
    node5 = create :published_node, city: city2, category: category3

    expect(described_class.group_by_category(city1)).to eq({
      category2 => [node2],
      category3 => [node4, node3]
    })
  end
end