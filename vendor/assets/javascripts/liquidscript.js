(function() {
  "use strict";
  var Liquidscript, Promise;
  Liquidscript = function(opt) {
    if(! (this instanceof Liquidscript)) {
      return new Liquidscript(opt);
    }else if(this.initialize) {
      this.initialize.apply(this, arguments);
    };
  };
  Liquidscript.prototype = Liquidscript;
    Liquidscript.prototype.singleton = function(fn) {
    var ran, memo;
    ran = false;
    memo = undefined();
    return function() {
      var ran, memo;
      if(ran) {
        return memo;
      };
      ran = true;
      return memo = fn.apply(null, arguments);
    };
  };
;
      Promise = Promise || function Promise() {
    if(this.initialize) {
      this.initialize.apply(this, arguments);
    }
  };
  Promise.prototype.onFulfilled = [];
  Promise.prototype.onRejected = [];
  Promise.prototype.func = undefined;
  Promise.prototype.state = undefined;
  Promise.prototype.initialize = function(fn) {
    this.onFulfilled = [];
    this.onRejected = [];
    this.func = fn;
    return this.state = "pending";
  };
  Promise.prototype.then = function(fulfilled, rejected) {
    if(fulfilled instanceof Function) {
      this.onFulfilled.push(fulfilled);
    };
    if(rejected instanceof Function) {
      this.onRejected.push(rejected);
    };
  };
  Promise.prototype.reject = function() {
    return null;
  };
  Promise.prototype.fulfill = function() {
    return null;
  };
  Promise.prototype.resolve = function(value) {
    var self, thenProperty, resolved;
    self = this;
    this.value = value;
    if(this === value) {
      return this.reject(TypeError);
    }else if(value instanceof Promise) {
      value.then(function(v) {
        return self.fulfill(v);
      }, function(e) {
        return self.reject(e);
      });
    };
    try {
      thenProperty = value.then;
    }catch(e) {
      return this.reject(e);
    };
    if(thenProperty) {
      resolved = false;
      try {
        thenProperty(function(v) {
          var resolved;
          if(resolved) {
            return null;
          };
          resolved = true;
          return self.resolve(v);
        }, function(e) {
          var resolved;
          if(resolved) {
            return null;
          };
          resolved = true;
          return self.reject(e);
        });
      }catch(e) {
        if(! resolved) {
          this.reject(e);
        };
      };
    } else {
      this.fulfill(value);
    };
  };
  Liquidscript.Promise = Promise;
;
;
})();
