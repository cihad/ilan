module ApplicationHelper
  def page_title title
    render(layout: "page_header") { title }
  end
end
