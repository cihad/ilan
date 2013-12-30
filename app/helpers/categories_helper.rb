module CategoriesHelper

  def icon name
    content_tag :i, nil, class: "glyphicon glyphicon-#{name}"
  end

  def name_with_icon item
    "%s %s".html_safe % [icon(item.icon), item.name]
  end

  def category_name_with_icon category
    category && name_with_icon(category) || nil
  end

end