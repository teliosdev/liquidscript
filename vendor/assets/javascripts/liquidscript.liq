(-> {

  :[ strict ]

  Liquidscript = (opt)-> {
    if(!(this instanceof Liquidscript))
      return new Liquidscript(opt)
    elsif(this.initialize)
      this.initialize.apply(this, arguments)
  }

  Liquidscript.prototype = Liquidscript

  class Liquidscript {
    singleton: (fn)-> {
      ran = false
      memo = undefined

      ()-> {
        if(ran) return memo
        ran = true
        memo = fn.apply(null, arguments)
      }
    }
  }

  :[ include "promise.liq" ]

})()
