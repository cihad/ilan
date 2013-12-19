require 'spec_helper'

describe "Cities" do
  describe "GET /cities" do
    before do
      city1 = stub_model(City, name: "Ankara")
      city2 = stub_model(City, name: "Bursa")
      City.stub(:all).and_return([city1, city2])
      visit cities_path
    end

    it "display cities" do
      expect(page).to have_content "Ankara"
      expect(page).to have_content "Bursa"
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
      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("home")

      expect(page).to have_selector '.breadcrumb li',
                      text: I18n.t("cities.index.cities")
    end
  end

  describe "GET /cities/new" do
    before do
      visit new_city_path
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
      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("home")

      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("cities.index.cities")

      expect(page).to have_selector '.breadcrumb li',
                      text: I18n.t("cities.new.new_city")
    end
  end

  describe "GET /cities/:id/edit" do
    let!(:city) { create :city }

    before do
      visit edit_city_path city
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
      expect(page).to have_content "ExampleCity"
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
      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("home")

      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("cities.index.cities")

      expect(page).to have_selector '.breadcrumb li',
                      text: I18n.t("cities.edit.editing_city")
    end
  end

  describe "DELETE /cities/:id" do
    it "destroys city" do
      city = create :city
      visit cities_path
      expect {
        click_link I18n.t('cities.index.destroy')
      }.to change(City, :count).by(-1)
    end
  end
end
