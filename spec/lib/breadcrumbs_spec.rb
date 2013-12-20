require './lib/breadcrumbs'

describe Breadcrumbs do

  it "#item" do
    item = double
    BreadcrumbItem.stub(:new).and_return(item)
    subject.item "Name", "/path"
    expect(subject.items).to eq([item])
  end

end

describe BreadcrumbItem do
  it "#active?" do
    expect(described_class.new("Example Name")).to be_active
  end
end