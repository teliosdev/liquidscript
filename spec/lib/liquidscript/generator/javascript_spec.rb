require "spec_helper"
require "yaml"

describe Liquidscript::Generator::Javascript do
  describe "with fixtures" do
    Dir.glob("spec/fixtures/*.generate.yml") do |file|
      content = YAML.load_file file
      file =~ /spec\/fixtures\/(.*)\.generate\.yml/

      it "generates #{$1}" do
        expect(content["data"]).to generate(content["compiled"])
      end
    end
  end
end
