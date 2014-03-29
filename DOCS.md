# ![Liquidscript](http://i.imgur.com/xbdhTsr.png)

**A javascript-based language that compiles to javascript.**  It compiles directly to javascript, requiring no runtime libraries.  It means to take away the awkwardness of javascript, but keep the very essence and ideals of javascript.  It incorporates some of the most well-used concepts, and allows you to write the code as you like.

## Installation

Add this line to your application's Gemfile:

    gem 'liquidscript'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install liquidscript

## Syntax

Liquidscript has a very similar syntax to Javascript.

	# This is a comment
	something = 2
    some_string = something.toString()

    if(some_string == '2) {
      console.log("It lives!")
    }

The thing that should stand out to you the most there is the lack of an end quote to the single quotes in the if conditional.  This is on purpose - a ending single quote is optional.

Note that there are also no semicolons (they don't exist in the language), and no `var` statement.  The `var` statement is made automagically by liquidscript, so you don't have to.

### Literals

#### String

Liquidscript has a very finite set of string literals - the only two options (so far) are double quotes and single quotes.  There are plans to introduce heredocs.  Double quotes are multiline, whereas **single quotes are limited to the same characters that identifiers are limited to**.  This is so that keys for objects (in the `object[key]` syntax feels more natural (i.e., `object['key]`).  Some examples:

	string = "hello

    world" # this'll translate to "hello\n\nworld"

    single = 'test # there doesn't need to be an endquote here.

That's it!

#### Functions

Functions are defined using the arrow syntax:

	some_function = -> {}

Brackets are **not** optional.  The parameter list before the arrow, however, is.  If you want something like coffeescript's fat arrow syntax, something like the following would have to be done:

	self = this

    some_function = -> {
    	# Change this to whatever property you wanted.
    	self.whatever
    }

A parameter list works exactly like you'd expect:

	some_function = (a, b, c)-> {
    	console.log(a, b, c)
    }

    some_function(1, 2, 3)

#### Numeric

There are numbers in liquidscript as well.  It follows the JSON spec on this to the letter.

	some_number = -2e+5

#### Array, Object

Arrays and objects are exactly like in javascript:

	array = [1, "test", 'foo, bar]

    object = {
    	test: "hello",
        foo: "world" # a colon here is allowed
    }

### Controls

Liquidscript has control statements like `if`, and `else`.  Liquidscript uses `elsif` instead of `else if`.

    if(some_variable == 2) {
    	console.log("It's 2!")
    } elsif(some_variable == 3) {
    	console.log("It's a 3!")
    } else {
    	console.log("I don't know what it is!")
    }

Liquidscript lacks `for`, `switch`, and `while`, but they will be added as well.

### Classes and Modules

#### Modules
This is where liquidscript gets interesting, in my opinion.  Modules are extreme syntaxic sugar:

	module SomeModule {
    	VERSION: "1.7.0"
    }

    SomeModule.VERSION # => 1.7.0

That compiles directly to:

	var SomeModule;
    SomeModule = {
    	VERSION: "1.7.0"
    };

    SomeModule.VERSION; // => 1.7.0

The point of modules, however, is to bind code together into units, in an easier to read syntax.  Commas are not needed between definitions, and other modules and classes can be defined within modules.

	module SomeModule {
    	module OtherModule {
        	VERSION: "1.7.0"
            VERSION_MAJOR: 1
            VERSION_MINOR: 7
            VERSION_PATCH: 0

            version: -> {
            	return SomeModule.OtherModule.VERSION.split('.')
            }
        }
    }

Which compiles directly to:

	var SomeModule, OtherModule;

    SomeModule = {
    	OtherModule: {
        	VERSION: "1.7.0",
            VERSION_MAJOR: 1,
            VERSION_MINOR: 7,
            VERSION_PATCH: 0,
            version: function() {
            	return SomeModule.OtherModule.VERSION.split('.');
            }
        }
    };

#### Classes

Classes are meant to be instantized with the `new` keyword.  They are defined very similarly to modules, but when values are defined, they default to being defined on the instance of the class:

	class Greeter {
    	# This is a special function that is called whenever a
        # new greeter is created.
    	initialize: (name)-> {
        	this.name = name
        }

        greet: -> {
        	console.log("Hello %s!", this.name)
        }
    }

    new Greeter("Alice").greet()

This would translate directly to this:

	var Greeter;

    Greeter = function Greeter() {
    	if(this.initialize) {
        	this.initialize.apply(this, arguments);
        }
    };

    Greeter.prototype.initialize = function(name) {
    	this.name = name;
    };

    Greeter.prototype.greet = function() {
    	console.log("Hello %s!", this.name);
    };

    new Greeter("Alice").greet()

This uses the functional prototype system in order to create instances of classes.  Inheritance is not yet supported, but there will be progress towards it.

If you want a method defined on the class itself instead of the instance, prefix the function name with `this`:

	class Greeter {
    	# This is a special function that is called whenever a
        # new greeter is created.
    	initialize: (name)-> {
        	this.name = name
        }

        greet: -> {
        	console.log("Hello %s!", this.name)
        }

        self.meet: (first, second)-> {
        	new Greeter(first).greet()
            new Greeter(second).greet()
        }
    }

   	Greeter.meet("Alice", "Bob")

This translates roughly to:

	// ...

    Greeter.meet = function(first, second) {
    	new Greeter(first).greet()
        new Greeter(second).greet()
    }

    // ...

# The End!

That wraps it all up!  If you're interested in more, checkout the [github repository](https://github.com/medcat/liquidscript) and read the documentation.
