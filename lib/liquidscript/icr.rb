require "liquidscript/icr/representable"
require "liquidscript/icr/code"
require "liquidscript/icr/set"
require "liquidscript/icr/context"
require "liquidscript/icr/variable"

module Liquidscript

  # The ICR (rather, Intermediate Code Representation)
  # is a method used to transform compiled code into
  # the corresponding javascript code.  It can be used
  # to optimize the code first, ensuring that the
  # resultant code is fast.  The point here is to
  # represent the code, and make it seem nice.
  module ICR
  end
end
