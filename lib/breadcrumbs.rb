class Breadcrumbs
  attr_accessor :items

  def initialize
    @items = []
  end

  def item name, path = nil
    items << BreadcrumbItem.new(name, path)
  end
end

BreadcrumbItem = Struct.new(:name, :path) do
  def active?
    path.nil?
  end
end
