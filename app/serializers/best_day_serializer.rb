class BestDaySerializer
  include FastJsonapi::ObjectSerializer
  attribute :best_day do |object|
    object.best_day.utc.iso8601(3)
  end
end
