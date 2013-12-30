require 'spec_helper'

describe "CategoriesController" do
  
  let(:category) { create :category, name: "Sample Category" }
  let(:city) { create :city }

  before do
    create :published_node, category: category, city: city, title: "Lorem Ipsum"
    create :node, category: category, city: city, title: "Sit Amet"
    visit category_path category
    click_link city.name
  end

  it "displays category title" do
    expect(page).to have_selector '.page-header h3', text: "Sample Category"
  end

  it "displays category icon" do
    expect(page).to have_selector ".glyphicon-#{category.icon}"
  end

  it "displays category nodes" do
    expect(page).to have_selector '.node-table tbody tr', count: 1
    expect(page).to have_selector '.node-table td a', text: "Lorem Ipsum"
  end

  it "displays only published nodes" do
    expect(page).to_not have_selector '.node-table td a', text: "Sit Amet"
  end

  it "not display pager when category nodes count less than 20" do
    expect(page).to_not have_selector '#pager'    
  end

  it "displays breadcrumb" do
    expect(page).to have_breadcrumbs [I18n.t('home'), category.name]
  end

  it "city selector" do
    create :published_node, category: category, title: "Duis aute irure dolor"
    create :published_node, category: category, city: city, title: "Anim id est laborum"
    visit category_path category
    click_link city.name
    expect(page).to_not have_selector 'td', text: "Duis aute irure dolor"
    expect(page).to have_selector 'td', text: "Anim id est laborum"
  end

  describe "nodes count greater than 20" do
    before do
      category.nodes.delete_all
      21.times { create :published_node, category: category, city: city }
      visit category_path category
      click_link city.name
    end
    
    it "displays pager" do
      expect(page).to have_selector '#pager'
    end

    it "displays 20 nodes on page 1" do
      expect(page).to have_selector '.node-table tbody tr', count: 20
    end

    it "displays 1 node on page 2" do
      visit category_path [category, :page, 2]
      expect(page).to have_selector '.node-table tbody tr', count: 1
    end

    it "displays pager buttons" do
      expect(page).to have_selector '#pager .btn-primary', text: "1"
      expect(page).to have_selector '#pager i.glyphicon-chevron-right'
      visit category_path(category, page: 2)
      expect(page).to have_selector '#pager .btn-primary', text: "2"
      expect(page).to have_selector '#pager i.glyphicon-chevron-left'
    end
  end

  describe "category selector" do
    let(:category) { create :category, name: "Lorem Ipsum" }

    before do
      visit root_path
    end

    it "displays category selector" do
      expect(page).to have_selector "#category-selector"
    end

    it "displays categories names and icons" do
      Category.all.each do |category|
        expect(page).to have_selector "#category-selector ul li a", text: "Lorem Ipsum"
        expect(page).to have_selector "#category-selector ul li a .glyphicon-#{category.icon}"
      end
    end

    it "when click to category goes to category page" do
      within("#category-selector") do
        click_link "Lorem Ipsum"
      end

      expect(current_path).to eq(category_path(category))
    end

    it "displays categories title" do
      expect(page).to have_selector "#category-selector .dropdown-toggle",
                      text: I18n.t('categories.index.categories')
    end

    it "displays current category name on button" do
      visit category_path category
      expect(page).to have_selector "#category-selector .dropdown-toggle",
                      text: "Lorem Ipsum"
    end

    it "displays current category icon on button" do
      visit category_path category
      expect(page).to have_selector ".glyphicon-#{category.icon}"
    end
  end

end