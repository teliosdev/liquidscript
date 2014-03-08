# ![Liquidscript](http://i.imgur.com/xbdhTsr.png)

[![Build Status](https://travis-ci.org/redjazz96/liquidscript.png?branch=master)](https://travis-ci.org/redjazz96/liquidscript) [![Coverage Status](https://coveralls.io/repos/redjazz96/liquidscript/badge.png?branch=master)](https://coveralls.io/r/redjazz96/liquidscript?branch=master) [![Code Climate](https://codeclimate.com/github/redjazz96/liquidscript.png)](https://codeclimate.com/github/redjazz96/liquidscript)

A javascript-based language that compiles to javascript.

## Installation

Add this line to your application's Gemfile:

    gem 'liquidscript'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liquidscript

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
