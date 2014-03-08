(-> {
  root = this
  previousUnderscore = root._
  breaker = {}
  ArrayProto = root.Array.prototype
  ObjProto = root.Object.prototype
  FuncProto = root.Function.prototype

  push = ArrayProto.push
  slice = ArrayProto.slice
  concat = ArrayProto.concat
  toString = ObjProto.toString
  hasOwnProperty = ObjProto.hasOwnProperty

  class _ {

  }

  if(typeof exports != 'undefined) {
    if(typeof root.module !== 'undefined && root.module.exports) {
      exports = root.module.exports = _
    }

    exports._ = _
  } else {
    root._ = _
  }
  _.VERSION = "1.6.0"
}).call()
