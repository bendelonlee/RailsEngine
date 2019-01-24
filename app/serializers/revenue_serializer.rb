class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id
  attribute :revenue do |object|
    object.revenue.to_s.insert(-3, '.')
  end
end
