class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.custom_where(attr, value)
    case attr
    when "name"
      where("upper(#{attr}) = ?", value.upcase)
    else
      where(attr => value)
    end
  end

end
