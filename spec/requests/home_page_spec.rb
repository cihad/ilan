require 'spec_helper'

describe "Home Page" do
  describe "GET /" do
    before do
      visit "/"
    end

    context "header" do
      it "displays logo" do
        expect(page).to have_selector ".header #logo", text: I18n.t('site_name')
      end

      it "displays add new node" do
        expect(page).to have_selector ".header a", text: I18n.t('nodes.add_new_node')
      end

      it "when click to add new button" do
        click_link I18n.t('nodes.add_new_node')
        expect(current_path).to eq(new_node_path)
      end

      it "city selector filters nodes by city" do
        node1 = create :published_node, title: "Lorem Ipsum"
        node2 = create :published_node, title: "Dolor Sit Amet"

        visit root_path
        click_link node1.city.name
        expect(page).to have_selector "p", text: "Lorem Ipsum"
        expect(page).to_not have_selector "p", text: "Dolor Sit Amet"

        click_link node2.city.name
        expect(page).to_not have_selector "p", text: "Lorem Ipsum"
        expect(page).to have_selector "p", text: "Dolor Sit Amet"
      end
    end

    context "body" do
      it "displays presentation" do
        category = mock_model Category, name: "Sample Category"
        node = mock_model Node, title: "Sample Node"
        catalog = [[category, node, node], [category, node]]
        Catalog.any_instance.stub(:catalog).and_return(catalog)

        visit root_path
        expect(page).to have_selector ".presentation .col-sm-6", count: 2
        expect(page).to have_selector ".presentation h4", count: 2
        expect(page).to have_selector "h4", text: "Sample Category"
        expect(page).to have_selector ".presentation p", count: 3
        expect(page).to have_selector "p", text: "Sample Node"
      end
    end

    context "footer" do
      it "displays footer" do
        expect(page).to have_selector ".footer"
      end
    end
  end
end