# frozen_string_literal: true

## [Unreleased]

## [0.1.0] - 2026-07-14

- Initial extraction from services / interface shared date helpers.
- `Date#yyyymmdd` / `Date.from_yyyymmdd`
- `Time#yyyymmdd` / `#yyyymmddhhmmss` / `.from_yyyymmddhhmmss` / `#hhmm` / `.from_hhmm`
- `Date#yearweek` / `.from_yearweek`, `date_of_next` / `date_of_last`, `for_datetime_column`
- `Time.datetime_epoch`
- `YyyymmddValidator` (ActiveModel)
- `Yyyymmdd.validate!` / `valid?` / `between` / `Helpers#validate_yyyymmdd!`
