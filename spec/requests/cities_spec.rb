require 'spec_helper'

describe "Cities" do

  describe "City Selector" do
    it "display current city name on city selector button" do
      city = double id: nil, name: "Great City"
      ApplicationController.any_instance.stub(:current_city).and_return(city)
      visit root_path
      expect(page).to have_selector "#city-selector .dropdown-toggle", text: "Great City"
    end

    it "click changes to current_city" do
      create :city, name: "Ankara"
      create :city, name: "Istanbul"
      visit root_path
      click_link "Istanbul"
      expect(page).to have_selector "#city-selector .dropdown-toggle", text: "Istanbul"
    end

    it "displays cities" do
      City.delete_all
      create :city, name: "Ankara"
      create :city, name: "Istanbul"

      visit root_path

      expect(page).to have_selector "#city-selector ul li", count: 2
      expect(page).to have_selector "#city-selector ul li", text: "Ankara"
      expect(page).to have_selector "#city-selector ul li", text: "Istanbul"
    end
  end


end
