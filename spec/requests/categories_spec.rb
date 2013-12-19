require 'spec_helper'

describe "Categories" do
  describe "GET /categories" do
    before do
      category1 = stub_model(Category, name: "Emlak")
      category2 = stub_model(Category, name: "Vasita")
      Category.stub(:all).and_return([category1, category2])
      visit categories_path
    end

    it "display categories" do
      expect(page).to have_content "Emlak"
      expect(page).to have_content "Vasita"
    end

    it "display categories title" do
      expect(page).to have_content I18n.t("categories.index.categories")
    end

    ["edit", "destroy", "new_category"].each do |word|
      it "display #{word} link" do
        expect(page).to have_selector "a", text: I18n.t("categories.index.#{word}")
      end
    end

    it "display breadcrumbs" do
      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("home")

      expect(page).to have_selector '.breadcrumb li',
                      text: I18n.t("categories.index.categories")
    end
  end

  describe "GET /categories/new" do
    before do
      visit new_category_path
    end
    
    it "display new category title" do
      expect(page).to have_content I18n.t('categories.new.new_category')
    end

    it "creates a new category"  do
      attrs = FactoryGirl.attributes_for :category 
      expect {
        fill_in "category_name", with: attrs[:name]
        click_on I18n.t('helpers.submit.create')
      }.to change(Category, :count).by(1)

      expect(page).to have_content I18n.t('categories.flash.created')
    end

    it "display breadcrumbs" do
      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("home")

      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("categories.index.categories")

      expect(page).to have_selector '.breadcrumb li',
                      text: I18n.t("categories.new.new_category")
    end
  end

  describe "GET /categories/:id/edit" do
    let!(:category) { create :category }

    before do
      visit edit_category_path category
    end

    it "display editing category title" do
      expect(page).to have_content I18n.t('categories.edit.editing_category')
    end

    it "modify existing category" do
      expect {
        fill_in "category_name", with: "ExampleCategory"
        click_on I18n.t('helpers.submit.update')
      }.to_not change(Category, :count)

      expect(page).to have_content I18n.t('categories.flash.updated')
      expect(page).to have_content "ExampleCategory"
    end

    it "display error messages" do
      fill_in "category_name", with: ""
      click_on I18n.t('helpers.submit.update')

      expect(page).to have_content I18n.t('categories.flash.not_updated')

      expect(page).to have_selector ".has-error .help-block",
        text: I18n.t('errors.messages.blank')

      expect(page).to have_selector ".has-error label",
        text: I18n.t('activerecord.attributes.category.name')
    end

    it "display breadcrumbs" do
      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("home")

      expect(page).to have_selector '.breadcrumb li a',
                      text: I18n.t("categories.index.categories")

      expect(page).to have_selector '.breadcrumb li',
                      text: I18n.t("categories.edit.editing_category")
    end
  end

  describe "DELETE /categories/:id" do
    it "destroys category" do
      category = create :category
      visit categories_path
      expect {
        click_link I18n.t('categories.index.destroy')
      }.to change(Category, :count).by(-1)
    end
  end
end
