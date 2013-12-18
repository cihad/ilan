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
    end

    context "footer" do
      it "displays footer" do
        expect(page).to have_selector ".footer"
      end
    end
  end
end