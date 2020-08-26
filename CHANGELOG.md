# 2.1.0 (August 22nd, 2020)

Changes:

* Removed support for < Ruby 2.5

Development:

* Updated dependencies
* Removed Gemfile.lock
* Installed Rake / Publish Steps

# 2.0.0 (April 7th, 2019)

*Breaking change in the formatter signature*

* Formatter#format signature was renamed and changed from: `format(value, method, arg)` to: `formatter(method, value arg)`.  This should help this method not conflict with Kernel#format and also match the signature closer to its visitor methods: `*_formatter(value, arg)`.

# 1.0.0 (April 7th, 2019)

Initial Release

# 0.0.1 (April 4th, 2019)

Library Shell.
