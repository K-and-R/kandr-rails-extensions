# `kandr-rails-extensions`

[![Maintainability](https://qlty.sh/gh/K-and-R/projects/kandr-rails-extensions/maintainability.svg)](https://qlty.sh/gh/K-and-R/projects/kandr-rails-extensions)
[![Test Coverage](https://qlty.sh/gh/K-and-R/projects/kandr-rails-extensions/coverage.svg)](https://qlty.sh/gh/K-and-R/projects/kandr-rails-extensions)

A set of Rails extensions for use in K&R Software applications.

Modifications to:

* [Array](./lib/kandr-rails-extensions/array.rb)
* [Date](./lib/kandr-rails-extensions/date.rb)
* [FalseClass](./lib/kandr-rails-extensions/false.rb)
* [File](./lib/kandr-rails-extensions/file.rb)
* [Hash](./lib/kandr-rails-extensions/hash.rb)
* [Integer](./lib/kandr-rails-extensions/integer.rb)
* [NilClass](./lib/kandr-rails-extensions/nil.rb)
* [OpenStruct](./lib/kandr-rails-extensions/open_struct.rb)
* [String](./lib/kandr-rails-extensions/string.rb)
* [Time](./lib/kandr-rails-extensions/time.rb)
* [TrueClass](./lib/kandr-rails-extensions/true.rb)

## Requirements

As the name implies, it is expected that this gem is used in conjunction with
Rails. However, Rails is not an actual dependency. Beyond Ruby, there are no
additional requirements.

## Installation

### With Bundler

* Add the following to your `Gemfile`

  ```ruby
  git_source(:github) do |repo_name|
    repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
    "https://github.com/#{repo_name}.git"
  end

  gem 'kandr-rails-extensions', github: 'K-and-R/kandr-rails-extensions'
  ```

* run the `bundle` command

### Without Bundler

* Use the `gem` command to install the `specific_install` gem, then install
  with `specific_install` like this:

  ```bash
  gem install specific_install
  gem specific_install git@github.com:K-and-R/kandr-rails-extensions.git
  ```

`kandr-rails-extensions` is copyright K&R Software, LLC and contributors, licensed under the [3-Clause BSD License](https://opensource.org/license/BSD-3-Clause). See the included [LICENSE](./LICENSE) file for details.

