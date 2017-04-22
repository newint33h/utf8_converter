# encoding: utf-8
require 'test_helper'

# Test class for the gem
class UTF8ConverterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::UTF8Converter::VERSION
  end

  def test_immutability
    text = 'Hello'.encode(Encoding::ISO_8859_1)
    text.to_utf8
    assert_equal(Encoding::ISO_8859_1, text.encoding)
    text.to_utf8!
    assert_equal(Encoding::UTF_8, text.encoding)
  end

  def test_some_encodings
    UTF8Converter.common_encodings = UTF8Converter::DEFAULT_COMMON_ENCODINGS

    # No conversion needed
    execute_test('hello', 'hello')

    # ISO_8859_1
    execute_test("A\xF1o".force_encoding(Encoding::ISO_8859_1), 'Año')

    # Windows_1252
    execute_test("\xFAltimo".force_encoding(Encoding::Windows_1252), 'último')

    # ISO_8859_1 as UTF_8
    execute_test("A\xF1o", 'Año')

    # Valid UTF_8 string
    execute_test("R\u00E9sum\u00E9", 'Résumé')

    # Invalid UTF_8 string
    execute_test("R\xE9sum\xE9", 'Résumé')
  end

  def test_no_common_encodings
    UTF8Converter.common_encodings = []

    # Windows_1252 without common encodings to test
    execute_test("\xFAltimo".force_encoding(Encoding::Windows_1252), '?ltimo')

    # ISO_8859_1 as UTF_8 without common encodings to test
    execute_test("A\xF1o", 'A?o')
  end

  def test_replace_character
    UTF8Converter.common_encodings = []

    UTF8Converter.default_replace_character = ''
    # ISO_8859_1 as UTF_8 without common encodings to test with empty replace character
    execute_test("A\xF1o", 'Ao')

    UTF8Converter.default_replace_character = UTF8Converter::DEFAULT_REPLACE_CHARACTER
    # ISO_8859_1 as UTF_8 without common encodings to test
    execute_test("A\xF1o", 'A?o')
  end

  def test_crash_prevention
    UTF8Converter.common_encodings = UTF8Converter::DEFAULT_COMMON_ENCODINGS

    # A valid binary encoding
    text = "\xA9".force_encoding(Encoding::BINARY)
    assert_equal(Encoding::BINARY, text.encoding)
    assert_equal(true, text.valid_encoding?)

    begin
      # Normal translation fails in Ruby
      text = "\xA9".force_encoding(Encoding::BINARY)
      text.encode(Encoding::UTF_8)
      assert(false, 'Successful conversion not expected')
    rescue
      assert(true, 'Failure expected')
    end

    # Convert binary data into UTF8
    text = "\xA9".force_encoding(Encoding::BINARY)
    text.to_utf8!
    assert_equal('©', text)
  end
end
