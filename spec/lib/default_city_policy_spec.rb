require 'spec_helper'
require 'default_city_policy'

describe DefaultCityPolicy do

  describe "#default_city_id" do
    it "when node count greater than 0" do
      Node.stub_chain(:with_published_state, :count).and_return(1)
      Node.stub_chain(:unscoped, :select, :with_published_state, :group, :size).and_return({
        1 => 50, 2 => 150, 3 => 100  
      })

      expect(described_class.default_city_id).to eq(2)
    end

    it "when any node exists" do
      Node.stub_chain(:with_published_state, :count).and_return(0)
      id = double
      City.stub_chain(:first, :id).and_return(id)

      expect(described_class.default_city_id).to eq(id)
    end

  end

  describe "#default_city" do
    it "when default_city_id returns to nil" do
      described_class.stub(:default_city_id).and_return(nil)
      blank_city = double
      described_class.stub(:blank_city).and_return(blank_city)
      
      expect(described_class.default_city).to eq(blank_city)
    end

    it "when default_city_id returns to id" do
      id = double
      city = double
      described_class.stub(:default_city_id).and_return(id)
      City.stub(:find_by).with(id: id).and_return(city)

      expect(described_class.default_city).to eq(city)
    end
  end

  it "#blank_city" do
    expect(described_class.blank_city.id).to be_nil
    expect(described_class.blank_city.name).to eq("None")
  end

end