# Matches the record with the corresponding log item among others.
RSpec::Matchers.define :log do |activity, data|
  match do |obj|
    obj.logs.where(:activity => activity).inject(false) do |result, r|
      result ||= (r.data == data)
    end
  end
end