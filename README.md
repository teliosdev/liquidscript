# ![Liquidscript](http://i.imgur.com/xbdhTsr.png)

[![Build Status](http://img.shields.io/travis/medcat/liquidscript.svg)](https://travis-ci.org/medcat/liquidscript) [![Coverage Status](http://img.shields.io/coveralls/medcat/liquidscript.svg)](https://coveralls.io/r/medcat/liquidscript?branch=master) [![Code Climate](http://img.shields.io/codeclimate/github/medcat/liquidscript.svg)](https://codeclimate.com/github/medcat/liquidscript) [![Gem Version](http://img.shields.io/gem/v/liquidscript.svg)](http://badge.fury.io/rb/liquidscript) [![Dependency Status](https://gemnasium.com/medcat/liquidscript.svg)](https://gemnasium.com/medcat/liquidscript) [![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://choosealicense.com/licenses/mit/)

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

1. Fork it ( http://github.com/medcat/liquidscript/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
