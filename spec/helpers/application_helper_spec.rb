require 'spec_helper'

describe ApplicationHelper do

  it "displays page header" do
    expect(helper.page_title('Example Title')).to like_of %Q{
      <div class="page-header">
        <h3>Example Title</h3>
      </div>
    }
  end

end