# encoding: utf-8
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'utf8_converter'

require 'minitest/autorun'

def execute_test(given_string, expected_string)
  new_string = given_string.to_utf8
  assert_equal(expected_string, new_string)
  assert_equal(Encoding::UTF_8, new_string.encoding)
end