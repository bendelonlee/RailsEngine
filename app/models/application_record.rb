class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.custom_where(attr, value)
    case attr
    when "name"
      where("upper(#{attr}) = ?", value.upcase)
    when "unit_price"
      value = value.delete(".").to_i
      where(attr => value)
    else
      where(attr => value)
    end
  end

end
