module NodesHelper

  def truncated_node_title node = @node
    node.title.truncate(30)
  end

  def decorate_bold str    
    bolded = str.truncate(11, :separator => ' ', omission: '')
    bolded_html = content_tag(:strong, bolded).html_safe
    str.gsub(/^#{bolded}/, bolded_html)
  end

end
