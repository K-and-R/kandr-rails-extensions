# Change Log

This file is used to list changes made in each version of
`kandr-rails-extensions`.  All notable changes to this project will be
documented in this file. This project adheres to [Semantic Versioning](http://semver.org/).

## 0.3.0 (2024-01-31)

* Add back in Ruby <3.2.0 `File.exists?` ...because it is more correct.
* Add modules (`FalseFalse` and `TrueTrue`; for classes `FalseClass`, `TrueClass`) with methods:
    * `false?`
    * `falsy?`
    * `to_bool`
    * `true?`
    * `truthy?`
* Add `ArrayIncludes` module providing the following methods to `Array`:
    * `includes?` (alias of `include?`)
* Add `IntegerBoolean` module providing the following methods to `Integer`:
    * `to_bool`
* Add `NilBoolean` module providing the following methods to `NilClass`:
    * `false?`
    * `falsy?`
    * `to_bool`
    * `true?`
    * `truthy?`
* Add methods to `NilCount` module providing the following to `NilClass`:
    * `first`
    * `last`
* Add method to `NilEmptyOrPresent` module providing the following to `NilClass`:
    * `blank?`
* Add `StringBoolean` module providing the following methods to `String`:
    * `falsy?`
    * `truthy?`
* Add `StringPresent` module providing the following methods to `String`:
    * `blank?`
    * `present?`
* Add `StringIncludes` module providing the following methods to `String`:
    * `includes?` (alias of `include?`)
* Add `StringTitleize` module providing the following methods to `String`:
    * `titleize` (with the option to allow exclusions)
    * `titleize_with_exclusions`

## 0.2.0 (2019-09-30)

* Move our modifications into submodules of `KandrRailsExtensions` module
* Include our submodules into the respective classes
* Add `String::to_bool`
* Require time module by default
* Add `TimeEpochTime` module providing the following methods to `Time`:
    * `to_epoch`
    * `to_posix`
    * `to_unix`
* Modify `Hash::drop(!)` to accept a block
* Add `Gemfile`
* Add RSpec tests
* Add analysis, linting, and coverage reporting to CodeClimate
* Add CodeClimate badges to `README`
* Use `MIT` license in `.gemspec` file; add `LICENSE` file
* Add GitHub templates

## 0.1.0 (2019-01-01)

* Initial classes as currently in use within several projects

---

Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax)
for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/)
describes the differences between markdown on github and standard markdown.
