require "liquidscript/generator/javascript/literals"
require "liquidscript/generator/javascript/metas"
require "liquidscript/generator/javascript/objects"

module Liquidscript
  module Generator

    # A list of all of the possible codes for javascript:
    #
    # - `:set`         ✔
    # - `:get`         ✔
    # - `:exec`        ✔
    # - `:expression`  ✔
    # - `:class`       ✔
    # - `:module`      ✔
    # - `:property`    ✔
    # - `:call`        ✔
    # - `:number`      ✔
    # - `:sstring`     ✔
    # - `:dstring`     ✔
    # - `:object`      ✔
    # - `:array`       ✔
    # - `:function`    ✔
    #
    # Each one of these must have a generate function.
    class Javascript < Base
      include Literals
      include Metas
      include Objects

      def initialize(top)
        @modules = []
        super
      end
    end
  end
end
