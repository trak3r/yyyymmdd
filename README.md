# frozen_string_literal: true

# Yyyymmdd

Integer calendar-day encoding (**YYYYMMDD**) and related compact date/time formats,
extracted from the services / interface shared date helpers.

## Why

Apps in this ecosystem store and query calendar days as plain integers (`20240714`)
rather than `date` columns. That makes range queries and grouping trivial, but needs
reliable conversion and validation. This gem is that conversion + validation layer.

## Install

```ruby
# Gemfile
gem 'yyyymmdd', path: '/path/to/yyyymmdd' # or via rubygems once published
```

```ruby
require 'yyyymmdd'
```

## Usage

### Date ↔ YYYYMMDD

```ruby
Date.new(2024, 7, 14).yyyymmdd     # => 20240714
Date.from_yyyymmdd(20240714)       # => #<Date: 2024-07-14>
Date.from_yyyymmdd('20240714')     # => #<Date: 2024-07-14>
Date.from_yyyymmdd(nil)            # => nil

Time.utc(2024, 7, 14, 15, 30).yyyymmdd  # => 20240714
```

### Datetime ↔ YYYYMMDDHHMMSS

```ruby
Time.utc(2024, 7, 14, 15, 30, 0).yyyymmddhhmmss  # => 20240714153000
Time.from_yyyymmddhhmmss(20240714153000)
```

### Time-of-day ↔ HHMM

```ruby
Time.zone.local(2015, 5, 30, 10, 55).hhmm  # => 1055
Time.from_hhmm(1055)                       # hour/min of current day
```

### Year-week

```ruby
Date.new(2024, 7, 14).yearweek     # => 202428 (strftime %Y%W)
Date.from_yearweek(202428)
```

### Validation

```ruby
Yyyymmdd.valid?(20140101)      # => true
Yyyymmdd.valid?('020140101')   # => false (leading zero / wrong length)
Yyyymmdd.validate!(params[:d]) # raises ArgumentError when invalid

# ActiveModel (same as services' YyyymmddValidator)
class FoodLogEntry
  include ActiveModel::Validations
  attr_accessor :yyyymmdd
  validates :yyyymmdd, yyyymmdd: true  # integer round-trip must match
end
```

The ActiveModel check requires the value to round-trip to the **same object**, so
the integer `20140101` is valid and the string `"20140101"` is not. Param
validation (`Yyyymmdd.validate!`) accepts either form when it is exactly 8 digits.

### Helpers mixin

```ruby
include Yyyymmdd::Helpers
validate_yyyymmdd!(params[:yyyymmdd])
```

### Day-key ranges

```ruby
Yyyymmdd.between(20240701, 20240703)
# => [20240701, 20240702, 20240703]

Yyyymmdd.between(20240701)  # end defaults to start + 7 days
```

### Other helpers (from the original monkey patch)

```ruby
Date.current.date_of_next(:monday)
Date.current.date_of_last(:sunday)
Date.current.for_datetime_column  # UTC midnight Time for datetime columns
Time.datetime_epoch               # Time.zone.local(1970, 1, 1)
```

## Origin in services

| This gem | Former location in services |
|----------|----------------------------|
| `Date` / `Time` extensions | `config/initializers/2700_monkey_date.rb` |
| `YyyymmddValidator` | `app/validators/yyyymmdd_validator.rb` |
| `Yyyymmdd.validate!` | `CustomValidators#validate_yyyymmdd!` |
| `Yyyymmdd.between` | `AbstractLogDaysBroker#yyyymmdds` |

## Development

```bash
bundle install
bundle exec rake test
```

## License

MIT — see [LICENSE](LICENSE).
