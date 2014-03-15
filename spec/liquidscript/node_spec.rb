require "spec_helper"
require "command/runner"

which_node = Command::Runner.new("which", "node")

if which_node.backend.class != Command::Runner::Backends::Backticks &&
   which_node.run.successful?
describe "Node support" do
  describe "with fixtures" do

    Dir.glob("spec/fixtures/*.yml") do |file|
      content = YAML.load_file file
      file =~ /spec\/fixtures\/(.*)\.yml/

      it "generates #{$1}" do
        expect(content["data"]).to run
      end
    end
  end
end
end
