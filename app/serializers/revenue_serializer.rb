class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attribute :revenue do |object|
    object.revenue.to_s.insert(-3, '.')
  end
end
