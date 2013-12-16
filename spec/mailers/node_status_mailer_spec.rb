require "spec_helper"

describe NodeStatusMailer do

  def mail_subject m
    I18n.t "node_status_mailer.#{m}.subject"
  end

  let(:node) { double :node,  email: "to@example.org",
                              title: "Deniz manzarali kiralik villa" }

  describe "published" do
    let(:mail) { NodeStatusMailer.published(node) }

    it "renders the headers" do
      mail.subject.should eq(mail_subject('published'))
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match(node.title)
    end
  end

  describe "rejected" do
    let(:reason) { "Sample reason" }
    let(:mail) { NodeStatusMailer.rejected(node, reason) }

    it "renders the headers" do
      mail.subject.should eq(mail_subject('rejected'))
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match(node.title)
      mail.body.encoded.should match(reason)
    end
  end

  describe "expired" do
    let(:mail) { NodeStatusMailer.expired(node) }

    it "renders the headers" do
      mail.subject.should eq(mail_subject('expired'))
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match(node.title)
    end
  end

end
