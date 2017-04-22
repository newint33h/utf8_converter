# encoding: utf-8
require 'utf8_converter/version'

# Class used to keep the default common encoding and the helper methods for the string conversion
class UTF8Converter
  DEFAULT_COMMON_ENCODINGS = [
    Encoding::ISO_8859_1, 
    Encoding::Windows_1252
  ]
  DEFAULT_REPLACE_CHARACTER = '?'

  class << self
    attr_accessor :common_encodings
    attr_accessor :default_replace_character
  end

  @common_encodings = DEFAULT_COMMON_ENCODINGS
  @default_replace_character = DEFAULT_REPLACE_CHARACTER

  def self.try_convert_from_encoding_to_utf8!(string, encoding)
    original_encoding = string.encoding
    begin
      string.force_encoding(encoding).encode!(Encoding::UTF_8)
      true
    rescue
      string.force_encoding(original_encoding)
      false
    end
  end 

  def self.convert_to_utf8!(string)
    if string.force_encoding(Encoding::UTF_8).valid_encoding?
      return string.encode!(Encoding::UTF_8)
    end
    @common_encodings.each do |encoding|
      return string if try_convert_from_encoding_to_utf8!(string, encoding)
    end
    string.encode!(Encoding::UTF_8, 
                   invalid: :replace, 
                   undef: :replace, 
                   replace: @default_replace_character)
  end 
end

# This partial class adds some useful methods to convert text to utf-8
class String

  def to_utf8!
    UTF8Converter.convert_to_utf8!(self)
  end

  def to_utf8
    dup.to_utf8!
  end
end
