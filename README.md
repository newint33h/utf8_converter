# UTF8 Converter

A Ruby gem that attempts to convert texts from unknown encodings to UTF8.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'utf8_converter'
```

And execute:

    $ bundle update

Or install it yourself as:

    $ gem install utf8_converter

## Usage

The normal usage for converting texts to UTF8 is the following:

```
require 'utf8_converter'

unknown_text = "R\u00E9sum\u00E9"

# Make a copy in UTF8 encoding
puts unknown_text.to_utf8
# Résumé

# Convert the actual variable to UTF8
unknown_text.to_utf8!
puts unknown_text
# Résumé

```

However the previous code will only convert the encodings listed in the default encodings listed
in the following variable:

```
p UTF8Converter.common_encodings
# => [#<Encoding:ISO-8859-1 (autoload)>, #<Encoding:Windows-1252 (autoload)>]
```

You can define the common encodings your application is expecting to receive:

```
UTF8Converter.common_encodings = UTF8Converter::DEFAULT_COMMON_ENCODINGS
# or
UTF8Converter.common_encodings = [Encoding::ISO_8859_1]
```

Any other text with a different encoding will result in a replacement of unknown characters to
a default replace character:

```
UTF8Converter.common_encodings = []

puts "A\xF1o".to_utf8
# A?o

UTF8Converter.default_replace_character = ''
puts "A\xF1o".to_utf8
# Ao
```
