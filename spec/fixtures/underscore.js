(function() {
  var root,previousUnderscore,breaker,ArrayProto,ObjProto,FuncProto,push,slice,concat,toString,hasOwnProperty,_;
  root = this;
  previousUnderscore = root._;
  breaker = {};
  ArrayProto = root.Array.prototype;
  ObjProto = root.Object.prototype;
  FuncProto = root.Function.prototype;
  push = ArrayProto.push;
  slice = ArrayProto.slice;
  concat = ArrayProto.concat;
  toString = ObjProto.toString;
  hasOwnProperty = ObjProto.hasOwnProperty;
    _ = _ || function _() {
    if(this.initialize) {
      this.initialize.apply(this, arguments);
    }
  }
;
  if( typeof  exports !== 'undefined') {
    if( typeof  root.module !==  'undefined' && root.module.exports) {
      exports = root.module.exports = _;
    };
    exports._ = _;
  } else {
    root._ = _;
  };
  _.VERSION = "1.6.0";
}).call();
