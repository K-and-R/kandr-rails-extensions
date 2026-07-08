# Change Log

This file is used to list changes made in each version of
`kandr-rails-extensions`.  All notable changes to this project will be
documented in this file. This project adheres to [Semantic Versioning](http://semver.org/).

## 0.5.0 (TBD)

* Expand RSpec coverage across extension modules (Array, Date, FalseClass,
  File, Hash, Integer, NilClass, OpenStruct, String, Time, TrueClass)
* Cover `HashDrop` (`drop` / `drop!`, multi-key, blocks) and `HashToOstruct`
* Cover `IntegerFactorial` / `IntegerTermial` and `Time` epoch / millisecond helpers
* Cover `OpenStruct` `to_json`, `delete`, and `key?` / `has_key?`
* Expand `String` specs (titleize API, slugify edge cases, trim family, includes)
* Fix `StringTitleize#titleize` / `titleize_with_exclusions` to use real keyword
  arguments (avoids Ruby 2.7 bare-hash kwargs deprecation warnings)
* Further Rubocop delinting; raise allowed method complexity where needed

## 0.4.0 (2026-07-08)

* Bump minimum required Ruby version to `2.7.0`
* Add runtime dependency on `ostruct`
* Add development dependency on `simplecov_json_formatter` for Qlty coverage upload
* Switch license from MIT to 3-clause BSD
* Add Qlty (formerly CodeClimate) configuration (`.qlty/`)
* Fix Qlty / CodeClimate badge links in `README`; clean up Gemfile GitHub example
* Update Rubocop configuration and delint library code
* Fix `StringTitleize#titleize` so it properly overrides ActiveSupport
  (`prepend` + `super`), supporting `:exclude` and falling back when blank
* Ignore `.ruby-version` in `.gitignore`

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
