# Before and after the period for removing ended scopes

def before_period_for_removing_ended(&block)
  Timecop.travel(Post::MAX_DELETABLE_PERIOD.minutes - 1, &block)
end

def after_period_for_removing_ended(&block)
  Timecop.travel(Post::MAX_DELETABLE_PERIOD.minutes + 1, &block)
end

