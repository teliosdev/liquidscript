RSpec::Matchers.define :be_token do |type, value|
  match do |data|
    data == Liquidscript::Scanner::Token.new(type, value)
  end

  description do
    "be token #{[type, value].inspect}"
  end
end
