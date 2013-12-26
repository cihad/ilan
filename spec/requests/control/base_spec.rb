require 'spec_helper'

describe "Control::BaseController" do

  context "when not login" do
    it "requires authentication" do
      visit control_path
      expect(page).to have_content "Access denied"
    end
  end

  context "when login" do
    before do
      Category.stub(:count).and_return(23)
      City.stub(:count).and_return(45)
      Node.stub(:count).and_return(67)
      login_as_admin
      visit control_path
    end

    it "displays control links" do
      expect(page).to have_selector 'li', text: I18n.t('control')
      expect(page).to have_selector 'li a', text: I18n.t('categories.index.categories')

      expect(page).to have_selector 'li span', text: "67"
      expect(page).to have_selector 'li a', text: I18n.t('node.index.node')

      expect(page).to have_selector 'li span', text: "23"
      expect(page).to have_selector 'li a', text: I18n.t('cities.index.cities')

      expect(page).to have_selector 'li span', text: "45"
      expect(page).to have_selector 'li a', text: I18n.t('logout')
    end

    it "logout session"

    it "display breadcrumb" do
      login_as_admin
      visit control_path

      expect(page).to have_breadcrumbs [I18n.t('home'), I18n.t('control')]
    end
  end


end