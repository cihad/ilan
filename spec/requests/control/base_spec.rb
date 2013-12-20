require 'spec_helper'

describe "Control::BaseController" do
  
  it "displays control links" do
    Category.stub(:count).and_return(23)
    City.stub(:count).and_return(45)

    visit control_path

    expect(page).to have_selector 'li', text: I18n.t('control')
    expect(page).to have_selector 'li a', text: I18n.t('categories.index.categories')
    expect(page).to have_selector 'li span', text: "23"
    expect(page).to have_selector 'li a', text: I18n.t('cities.index.cities')
    expect(page).to have_selector 'li span', text: "45"
  end


end