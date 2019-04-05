*This is a Ruby implementation of [Stringent](https://github.com/bluemarblepayroll/stringent).  The name Stringent was already taken within RubyGems so this was named Stringento instead.*

---

# Stringento

[![Gem Version](https://badge.fury.io/rb/stringento.svg)](https://badge.fury.io/rb/stringento) [![Build Status](https://travis-ci.org/bluemarblepayroll/stringento.svg?branch=master)](https://travis-ci.org/bluemarblepayroll/stringento) [![Maintainability](https://api.codeclimate.com/v1/badges/22aabc80514fe3db20da/maintainability)](https://codeclimate.com/github/bluemarblepayroll/stringento/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/22aabc80514fe3db20da/test_coverage)](https://codeclimate.com/github/bluemarblepayroll/stringento/test_coverage) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This library provides a pluggable string templating system.  At its core, it can take a templated string (such as: '{last_name}, {first_name} {middle_name}') and a input object (default is a plain old Ruby object) and it will dynamically resolve the string based on the input.  It also provides two optional arguments which help make this library 'pluggable':

1. Custom Resolver: Instead of passing in a PORO as your input, you can pass in other object types and use a custom resolver for value getting.
1. Custom Formatter: Customize the way each string token is rendered by extending the token syntax to: {token:formatter:argument}.  Formatter is the formatting method to call and argument will be passed in as meta-data/options.


## Installation

To install through Rubygems:

````
gem install install stringento
````

You can also add this to your Gemfile:

````
bundle add stringento
````

## Examples

### Getting Started

Consider the following example:

> 'The {fox_speed} brown fox jumps over the {dog_speed} dog'

We can evaluate this by executing:

```ruby
example = 'The {fox_speed} brown fox jumps over the {dog_speed} dog'
input = { 'fox_speed' => 'quick', 'dog_speed' => 'lazy' }

result = Stringento.evaluate(example, input)
```

Result should now be: 'The quick brown fox jumps over the lazy dog'

### Custom Resolution

The above example works just fine using the default object value resolver, but you can also pass in a custom function that will serve as resolver.  That way you could use dot notation for value resolution.  For example:

```ruby
class NestedHashResolver
  def resolve(value, input)
    parts = value.to_s.split('.').map(&:to_sym)

    input ? input.dig(*parts) : nil
  end
end

example = 'The {fox.speed} brown fox jumps over the {dog.speed} dog'
input = { fox: { speed: 'quick' }, dog: { speed: 'lazy' } }

result = Stringento.evaluate(example, input, resolver: NestedHashResolver.new)
```

The ```result``` variable should now be: 'The quick brown fox jumps over the lazy dog'

### Custom Formatting

Another extendable aspect is formatting.  Consider a basic example where we want to show 'Yes' for a true value, 'No' for a false value, and an 'Unknown' for a null value:

> 'The fox is quick: {fox.quick::yes_no_unknown}'

In this case we can use a custom formatter called yes_no_unknown that understands how to do this for us.  The custom formatter is controlled externally from this library, which means you can use this for whatever purpose you see fit.  Here would be an example implementation of this custom formatter:

```ruby
class CustomFormatter < ::Stringento::Formatter
  def yes_no_unknown_formatter(value, _arg)
    if value.nil?
      'Unknown'
    elsif value
      'Yes'
    else
      'No'
    end
  end
end
```

Now, we can pass this in and consume it as follows:

```ruby
class NestedHashResolver
  def resolve(value, input)
    parts = value.to_s.split('.').map(&:to_sym)

    input ? input.dig(*parts) : nil
  end
end

example = 'The fox is quick: {fox.quick::yes_no_unknown}'
input = { fox: { quick: true } }

result = evaluate(example, input, resolver: NestedHashResolver.new, formatter: CustomFormatter.new)
```

The ```result``` variable should now be: 'The fox is quick: Yes'

*Note: If we wanted to use the default resolver we could omit resolver instead of the custom resolver.*

## Contributing

### Development Environment Configuration

Basic steps to take to get this repository compiling:

1. Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) (check stringento.gemspec for versions supported)
2. Install bundler (gem install bundler)
3. Clone the repository (git clone git@github.com:bluemarblepayroll/stringento.git)
4. Navigate to the root folder (cd stringento)
5. Install dependencies (bundle)

### Running Tests

To execute the test suite run:

````
bundle exec rspec spec --format documentation
````

Alternatively, you can have Guard watch for changes:

````
bundle exec guard
````

Also, do not forget to run Rubocop:

````
bundle exec rubocop
````

### Publishing

Note: ensure you have proper authorization before trying to publish new versions.

After code changes have successfully gone through the Pull Request review process then the following steps should be followed for publishing new versions:

1. Merge Pull Request into master
2. Update ```lib/stringento/version.rb``` using [semantic versioning](https://semver.org/)
3. Install dependencies: ```bundle```
4. Update ```CHANGELOG.md``` with release notes
5. Commit & push master to remote and ensure CI builds master successfully
6. Build the project locally: `gem build stringento`
7. Publish package to RubyGems: `gem push stringento-X.gem` where X is the version to push
8. Tag master with new version: `git tag <version>`
9. Push tags remotely: `git push origin --tags`

## License

This project is MIT Licensed.
