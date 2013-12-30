require 'spec_helper'

describe CategoriesHelper do

  it "#icon" do
    expect(helper.icon('example-icon')).to like_of %Q{
      <i class="glyphicon glyphicon-example-icon"></i>
    }
  end

  it "#name_with_icon" do
    item = double name: "Name", icon: "icon"
    expect(helper.name_with_icon(item)).to like_of %Q{
      <i class="glyphicon glyphicon-icon"></i> Name
    }
  end

  describe "#category_name_with_icon" do
    it "if category is exists" do
      item = double
      view = double
      helper.stub(:name_with_icon).with(item).and_return(view)
      expect(helper.category_name_with_icon(item)).to eq(view)
    end

    it "if category is not exists" do
      expect(helper.category_name_with_icon(nil)).to be_nil
    end
  end

end
