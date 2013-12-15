require 'spec_helper'

describe "Cities" do
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
  end

  describe "GET /categories/new" do
    it "display new category title" do
      visit new_category_path
      expect(page).to have_content I18n.t('categories.new.new_category')
    end

    it "creates a new category"  do
      visit new_category_path
      attrs = FactoryGirl.attributes_for :category 
      expect {
        within("//form[@id='new_category']") do
          fill_in "category_name", with: attrs[:name]
          click_on I18n.t('helpers.submit.create')
        end
      }.to change(Category, :count).by(1)

      expect(page).to have_content I18n.t('categories.flash.created')
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
        within("//form[@class='edit_category']") do
          fill_in "category_name", with: "ExampleCategory"
          click_on I18n.t('helpers.submit.update')
        end
      }.to_not change(Category, :count)

      expect(page).to have_content I18n.t('categories.flash.updated')
      expect(page).to have_content "ExampleCategory"
    end

    it "display error messages" do
      fill_in "category_name", with: ""
      click_on I18n.t('helpers.submit.update')
    
      expect(page).to have_content I18n.t('categories.flash.not_created')

      expect(page).to have_selector "#error_explanation li",
        text: I18n.t('errors.messages.blank')

      expect(page).to have_selector ".field_with_errors label",
        text: I18n.t('activerecord.attributes.category.name')
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
