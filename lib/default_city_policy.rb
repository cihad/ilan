require 'active_support/core_ext/object/try'

class DefaultCityPolicy

  def self.default_city_id
    id =  Node.with_published_state.count > 0 && 
          Node.unscoped.select(:city_id).with_published_state.group(:city_id).size.
            sort_by { |_, node_count| node_count }.last.first

    id || City.first.try(:id)
  end

  def self.default_city
    default_city_id && City.find_by(id: default_city_id) || blank_city
  end

  def self.blank_city
    Struct.new(:id, :name).new(nil, "None")
  end

end

