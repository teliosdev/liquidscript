(-> {

  ![ strict ]
  
  Liquidscript = (opt)-> {
    if(!(this instanceof Liquidscript))
      return new Liquidscript(opt)
    elsif(this.initialize)
      this.initialize.apply(this, arugments)
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
    
    class Promise {
      on-fulfilled: []
      on-rejected:  []
      func:         undefined
      state:        undefined
    
      initialize: (fn)-> {
        this.on-fulfilled = []
        this.on-rejected  = []
        this.func         = fn
        this.state        = "pending"
      }
      
      then: (fulfilled, rejected)-> {
        if(fulfilled instanceof Function) {
          this.on-fulfilled.push(fulfilled)
        }
        
        if(rejected instanceof Function) {
          this.on-rejected.push(rejected)
        }
      }
      
      resolve: (value)-> {
        self = this
        this.value = value
        if(this == value)
          return reject(TypeError)
        elsif(value instanceof Promise) {
          value.then((v)-> self.fulfill(v), (e)-> self.reject(e))
        }
        
        try {
          then-property = value.then
        } catch(e) {
          return reject(e)
        }
        
        if(then-property) {
          resolved = false
          
          try {
            then-property((v)-> {
              if(resolved) return null
              resolved = true
              self.resolve(v)
            }, (e)-> {
              if(resolved) return null
              resolved = true
              self.reject(e)
            })
          catch(e) {
            unless(resolved) {
              reject(e)
            }
          }
        }
      } else {
        fulfill(value)
      }
      
    }
    
  }

})()
