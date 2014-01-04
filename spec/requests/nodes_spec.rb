require 'spec_helper'

describe "Nodes" do
  describe "GET /nodes/:id" do

    let(:node) { create :node_with_images }

    before { visit "/nodes/#{node.to_param}" }

    it "renders" do
      expect(page.status_code).to be(200)
    end

    it "display status" do
      def clear_strong text
        text.gsub(/<\/?strong>/, "")
      end

      expect(page).to have_selector '.alert-warning',
        text: clear_strong(I18n.t('nodes.show.status.pending_approval_html'))

      visit node_path(create :published_node)
      expect(page).to_not have_selector '.alert'

      visit node_path(create :node, status: "expired")
      expect(page).to have_selector '.alert-danger',
        text: clear_strong(I18n.t('nodes.show.status.expired_html'))

      visit node_path(create :node, status: "rejected")
      expect(page).to have_selector '.alert-danger',
        text: clear_strong(I18n.t('nodes.show.status.rejected_html'))
    end

    it "display title" do
      expect(page).to have_selector '.page-header', text: node.title
    end

    it "display images title" do
      expect(page).to have_selector 'dt', text: I18n.t('nodes.show.images')
    end

    it "display images" do
      expect(page).to have_selector '.carousel-inner .item', count: 3
    end

    it "display no image" do
      node = create :node
      visit node_path(node)
      
      expect(page).to have_selector 'dd', text: I18n.t('images.no_image')
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

    it "display category icon" do
      expect(page).to have_selector "i.glyphicon-#{node.category.icon}"
    end

    it "display category" do
      expect(page).to have_selector 'dd', text: node.category.name
    end


    it "display breadcrumb" do
      expect(page).to have_breadcrumbs [I18n.t('home'),
                                        node.category.name,
                                        node.title]
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

    context "node email" do
      it "displays cookie email when valid email" do
        fill_in "node_email", with: "valid_email@example.com"
        click_on I18n.t('helpers.submit.create')

        visit new_node_path
        expect(page.find_field('node_email').value).to eq("valid_email@example.com")
      end

      it "doesnt display cookie email when invalid email" do
        fill_in "node_email", with: "invalid_email@example"
        click_on I18n.t('helpers.submit.create')

        visit new_node_path
        expect(page.find_field('node_email').value).to be_nil
      end
    end

    context "#with valid attributes" do
      let(:valid_attributes) { FactoryGirl.attributes_for :node }

      it "creates a new node" do
        expect {
          fill_in     "node_title",       with: valid_attributes[:title]
          fill_in     "node_description", with: valid_attributes[:description]
          fill_in     "node_contact",     with: valid_attributes[:contact]
          fill_in     "node_email",       with: valid_attributes[:email]
          attach_file "node_imgs",        [Rails.root.join('spec/support/images/01.png')]
          select      "Ankara",           from: "node_city_id"
          select      "Emlak",            from: "node_category_id"
          click_on    I18n.t('helpers.submit.create')
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
            select "", from: "node_city_id"
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
