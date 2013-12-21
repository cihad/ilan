require 'spec_helper'

describe "Nodes" do
  describe "GET /nodes/:id" do

    let(:node) { create :node }

    before { visit "/nodes/#{node.to_param}" }

    it "renders" do
      expect(page.status_code).to be(200)
    end

    it "display title" do
      expect(page).to have_selector '.page-header', text: node.title
    end

    it "display description title" do
      expect(page).to have_selector 'dt', text: I18n.t('nodes.show.description')
    end

    it "display description" do
      expect(page).to have_selector 'dd', text: node.description
    end

    it "display contact title" do
      expect(page).to have_selector 'dt', text: I18n.t('nodes.show.contact')
    end

    it "display contact" do
      expect(page).to have_selector 'dd address', text: node.contact
    end

    it "display city title" do
      expect(page).to have_selector 'dt', text: I18n.t('nodes.show.city')
    end

    it "display city" do
      expect(page).to have_selector 'dd', text: node.city.name
    end

    it "display category title" do
      expect(page).to have_selector 'dt', text: I18n.t('nodes.show.category')
    end

    it "display category" do
      expect(page).to have_selector 'dd', text: node.category.name
    end

    it "display breadcrumb" do
      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t('home')

      expect(page).to have_selector '.breadcrumb li a',
                      text: node.category.name

      expect(page).to have_selector '.breadcrumb li',
                      text: node.title
    end
  end

  describe "GET /nodes/new" do
    before do
      create :city, name: "Ankara"
      create :category, name: "Emlak"
      visit "/nodes/new"
    end

    it "renders" do
      expect(page.status_code).to be(200)
    end

    it "display new node title" do
      expect(page).to have_selector '.page-header', text: I18n.t('nodes.new.new_node')
    end

    context "#with valid attributes" do
      let(:valid_attributes) { FactoryGirl.attributes_for :node }

      it "creates a new node" do
        expect {
          within("//form[@id='new_node']") do
            fill_in "node_title", with: valid_attributes[:title]
            fill_in "node_description", with: valid_attributes[:description]
            fill_in "node_contact", with: valid_attributes[:contact]
            fill_in "node_email", with: valid_attributes[:email]
            select  "Ankara", from: "node_city_id"
            select  "Emlak", from: "node_category_id"
            click_on I18n.t('helpers.submit.create')
          end
        }.to change(Node, :count).by(1)

        expect(page).to have_content I18n.t('nodes.flash.created')
      end
    end

    context "#with unvalid attributes" do
      def attribute_name(attr)
        I18n.t("activerecord.attributes.node.#{attr}")
      end

      let(:valid_attributes) { FactoryGirl.attributes_for :node }

      it "dont creates a new node and display error messages" do
        expect {
          within("//form[@id='new_node']") do
            fill_in "node_title", with: ""
            fill_in "node_description", with: ""
            fill_in "node_contact", with: ""
            fill_in "node_email", with: ""
            click_on I18n.t('helpers.submit.create')
          end
        }.to_not change(Node, :count)

        [:title, :description, :contact, :email, :city, :category].each do |attr|
          expect(page).to have_selector ".has-error label",
                          text: attribute_name(attr)          
        end
      end

      it "if email is invalid, dont creates" do
        expect {
          within("//form[@id='new_node']") do
            fill_in "node_title", with: valid_attributes[:title]
            fill_in "node_description", with: valid_attributes[:description]
            fill_in "node_contact", with: valid_attributes[:contact]
            fill_in "node_email", with: "invalid_email"
            select  "Ankara", from: "node_city_id"
            select  "Emlak", from: "node_category_id"
            click_on I18n.t('helpers.submit.create')
          end
        }.to_not change(Node, :count)

        expect(page).to have_selector ".has-error label",
                        text: attribute_name(:email)

        expect(page).to have_selector ".has-error .help-block",
          text: I18n.t('activerecord.errors.models.node.attributes.email.invalid')
      end
    end
  end
end
