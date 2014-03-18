# ![Liquidscript](http://i.imgur.com/xbdhTsr.png)

[![Build Status](http://img.shields.io/travis/redjazz96/liquidscript.svg)](https://travis-ci.org/redjazz96/liquidscript) [![Coverage Status](http://img.shields.io/coveralls/redjazz96/liquidscript.svg)](https://coveralls.io/r/redjazz96/liquidscript?branch=master) [![Code Climate](http://img.shields.io/codeclimate/github/redjazz96/liquidscript.svg)](https://codeclimate.com/github/redjazz96/liquidscript) [![Gem Version](http://img.shields.io/gem/v/liquidscript.svg)](http://badge.fury.io/rb/liquidscript) [![Dependencies](http://img.shields.io/gemnasium/redjazz96/liquidscript.svg)](https://gemnasium.com/redjazz96/liquidscript) [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://choosealicense.com/licenses/mit/)

A javascript-based language that compiles to javascript.

## Installation

Add this line to your application's Gemfile:

    gem 'liquidscript'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liquidscript
    
If you're using Sprockets in your application, place this in
your Gemfile:

    gem 'liquidscript', require: 'sprockets/liquidscript'

## Usage

To use liquidscript:

```
TODO: usage example
```

The language of liquidscript:

```coffeescript
# This is an object.

{
  test: "hello",

  # Note here that a single-quoted string does not have an ending
  # delimiter.  This is on purpose.
  foo: 'bar # ' # syntax highlighting fix
}
```

```coffeescript
# This is a function

func = ()-> {
  console.log("hello world")
}

func()
```

## Contributing

1. Fork it ( http://github.com/redjazz96/liquidscript/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
