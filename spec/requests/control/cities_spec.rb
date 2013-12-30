require 'spec_helper'

describe "Control::Cities" do
  before do
    login_as_admin
  end

  describe "GET control/cities" do
    before do
      create :city, name: "Ankara"
      create :city, name: "Bursa"
      visit control_cities_path
    end

    it "display cities" do
      expect(page).to have_selector 'td', text: "Ankara"
      expect(page).to have_selector 'td', text: "Bursa"
    end

    ["cities", "city"].each do |word|
      it "display #{word} title" do
        expect(page).to have_content I18n.t("cities.index.#{word}")
      end
    end

    ["edit", "destroy", "new_city"].each do |word|
      it "display #{word} link" do
        expect(page).to have_selector "a", text: I18n.t("cities.index.#{word}")
      end
    end

    it "display breadcrumbs" do
      expect(page).to have_breadcrumbs [ I18n.t("home"),
                                         I18n.t("control"),
                                         I18n.t("cities.index.cities")]
    end
  end

  describe "GET control/cities/new" do
    before do
      visit new_control_city_path
    end

    it "display new city title" do
      expect(page).to have_content I18n.t('cities.new.new_city')
    end

    it "creates a new city"  do
      attrs = FactoryGirl.attributes_for :city 
      expect {
        fill_in "city_name", with: attrs[:name]
        click_on I18n.t('helpers.submit.create')
      }.to change(City, :count).by(1)

      expect(page).to have_content I18n.t('cities.flash.created')
    end

    it "display breadcrumbs" do
      expect(page).to have_breadcrumbs [I18n.t("home"),
                                        I18n.t("control"),
                                        I18n.t("cities.index.cities"),
                                        I18n.t("cities.new.new_city")]
    end
  end

  describe "GET control/cities/:id/edit" do
    let!(:city) { create :city }

    before do
      visit edit_control_city_path city
    end

    it "display editing city title" do
      expect(page).to have_content I18n.t('cities.edit.editing_city')
    end

    it "modify existing city" do
      expect {
        fill_in "city_name", with: "ExampleCity"
        click_on I18n.t('helpers.submit.update')
      }.to_not change(City, :count)

      expect(page).to have_content I18n.t('cities.flash.updated')
      expect(page).to have_selector 'td', text: "ExampleCity"
    end

    it "display error messages" do
      fill_in "city_name", with: ""
      click_on I18n.t('helpers.submit.update')
    
      expect(page).to have_selector ".has-error .help-block",
        text: I18n.t('activerecord.errors.models.city.blank')

      expect(page).to have_selector ".has-error label",
        text: I18n.t('activerecord.attributes.city.name')
    end

    it "display breadcrumbs" do
      expect(page).to have_breadcrumbs [I18n.t("home"),
                                        I18n.t("control"),
                                        I18n.t("cities.index.cities"),
                                        I18n.t("cities.edit.editing_city")]
    end
  end

  describe "DELETE control/cities/:id" do
    it "destroys city" do
      city = create :city
      visit control_cities_path
      expect {
        click_link I18n.t('cities.index.destroy')
      }.to change(City, :count).by(-1)
    end
  end
end
