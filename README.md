# Terastream

JRuby client to query data from the Teradata data warehouse. Used in
your own programs as a gem or via the terasql cli. The client takes a
plugin based approach to formatting query results and streaming
data to an output location.

Bundled formatter and output middlewares support formatting results as

- Ruby objects
- JSON records
- lines of CSV

and streaming results to

- STDOUT
- Kinesis
- Kafka
- Redis pubsub

## Installation

- install JRuby (9.0.0.0 preferred but any jruby should work)

Add this line to your application's Gemfile:

```ruby
gem 'terastream'
```

And then execute:

    $ bundle

Or install it yourself without bundler via:

    $ gem install terastream

## Usage

If using Terastream in your own application:

```ruby
client = Terastream.new do |connection|
  connection.username  = "something"
  connection.password  = "password"
  connection.hostname  = "somehost.somwhere"
  connection.formatter = Terastream::JsonBuilder
  connection.output    = Terastream::Output::Redis
end

results = client.query("SELECT * FROM sometable")
results.each do |result|
  p result.field
end

```

Or using the terasql command line utility

```
terasql --username username --password password --host somehost.somewhere --formatter json --output redis --query "SELECT * FROM sometable"
```

## Todo

- Support for DDL files being run before final query execution

## Warning

ALPHA SOFTWARE!!!!!

## Contributing

1. Fork it ( https://github.com/nordstrom/terastream/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


# License

This software is licensed under the MIT license, quoted below.

> Copyright (c) 2015 Nordstrom, David Von Lehman & Ramin Keene

> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:

> The above copyright notice and this permission notice shall be included in
> all copies or substantial portions of the Software.

> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE SOFTWARE.
