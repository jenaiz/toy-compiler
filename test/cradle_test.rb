#!/usr/bin/env ruby

require 'test/unit'
require 'lib/cradle'

class CradleTest < Test::Unit::TestCase
  def test_init
    assert false
  end
  
  def test_get_char
    assert false
  end
  
  def test_error
    assert false
  end

  def test_expected
    assert false
  end
  
  def test_match
    assert false
  end

  def test_is_digit
    assert_equal true, is_digit?(1), "This is not a digit"
    assert_equal false, is_digit?('w'), "This is not a digit"
  end

  def test_is_alpha
    assert_equal true, is_alpha?('w'), "This is not a character"
    assert_equal false, is_alpha?(1), "This is not a character"  
  end
  
  def test_get_name
    assert false
  end
  
  def test_get_num
    assert false
  end
  
  def test_emit
    assert false
  end
  
  def test_emit_ln
    assert false
  end

  ## Chapter II
  def test_expression
    assert false
  end
  
  def test_add
    assert false
  end
  
  def test_subtract
    assert false
  end
  
  def test_factor
    assert false
  end
  
  def test_multiply
    assert false
  end
  
  def test_divide
    assert false
  end
  
  def assignment
    assert true
  end
end
  