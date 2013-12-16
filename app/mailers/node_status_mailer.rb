class NodeStatusMailer < ActionMailer::Base
  default from: "from@example.com"

  def published node
    @node = node

    mail_to node.email
  end

  def rejected node, reason
    @node = node
    @reason = reason

    mail_to node.email
  end

  def expired node
    @node = node
    mail_to node.email
  end

  private

    def mail_to email
      mail to: email
    end
end
