require 'spec_helper'

describe "Control::Cities" do
  let!(:node) { create :node }
  let!(:published_node) { create :published_node }

  before do
    login_as_admin
    visit control_nodes_path
  end

  describe "GET control/nodes" do
    it "has nodes title" do
      expect(page).to have_content I18n.t('nodes.index.nodes')
    end

    it "has node title" do
      expect(page).to have_selector 'th', text: I18n.t('nodes.index.node')
    end

    it "has status title" do
      expect(page).to have_selector 'th', text: I18n.t('nodes.index.status')
    end

    it "has actions title" do
      expect(page).to have_selector 'th', text: I18n.t('nodes.index.actions')
    end

    it "has node variables" do
      expect(page).to have_selector 'td', text: node.title
      expect(page).to have_selector 'td', text: I18n.t("nodes.status.#{node.status}")
      expect(page).to have_selector 'td form', count: 2
    end
    
    it "filter" do
      expect(page).to have_content node.title
      expect(page).to_not have_content published_node.title

      select  I18n.t('simple_form.options.node_filter.status.published'),
              from: "node_filter_status"
      click_button I18n.t('helpers.submit.node_filter.submit')

      expect(page).to_not have_content node.title
      expect(page).to have_content published_node.title
    end

  end

  describe "PUT control/nodes/:id" do
    
    it "changes node status from pending approval to published" do
      expect {
        within("#node_#{node.to_param}") do
          click_on I18n.t('nodes.events.publish')
        end
      }.to change(Node.with_published_state, :count).by(1)
    end
    
  end
end
