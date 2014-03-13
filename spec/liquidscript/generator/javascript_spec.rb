require "spec_helper"
require "yaml"

describe Generator::Javascript do
  describe "with fixtures" do
    Dir.glob("spec/fixtures/*.generate.yml") do |file|
      content = YAML.load_file file
      file =~ /spec\/fixtures\/(.*)\.generate\.yml/

      it "generates #{$1}" do
        begin
          expect(content["data"]).to generate(content["compiled"])
        rescue Error
          p Scanner::Liquidscript.new(content["data"]).each.to_a
          raise
        end
      end
    end
  end
end
