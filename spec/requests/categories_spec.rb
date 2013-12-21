require 'spec_helper'

describe "CategoriesController" do
  
  let(:category) { create :category, name: "Sample Category" }

  before do
    create :node, category: category, title: "Lorem Ipsum"
    create :node, category: category, title: "Sit Amet"
    visit category_path category
  end

  it "displays category title" do
    expect(page).to have_selector '.page-header h3', text: "Sample Category"
  end

  it "displays category nodes" do
    expect(page).to have_selector '.node-table tbody tr', count: 2
    expect(page).to have_selector '.node-table td a', text: "Lorem Ipsum"
    expect(page).to have_selector '.node-table td a', text: "Sit Amet"
  end

  it "displays pager when category nodes count greater than 20"

end