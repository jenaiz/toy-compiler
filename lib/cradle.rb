#!/usr/bin/env ruby

## Chapter I
def init
  get_char
end

# Read New Character From Input Stream
#
def get_char
  @look = gets.chomp
end

# Report an Error
#
def error(text)
  puts "\nError: " + text
end

# Report What Was Expected
#
def expected(text)
  abort(text + " Expected")
end

# Match a Specific Input Character
#
def match(input)
  @look == input ? get_char : expected("'" + input.to_s + "'")
end

# Recognize a Decimal Digit
#
def is_digit?(input)
    !!Float(input) rescue false
end

# Recognize an Alpha Character
#
def is_alpha?(input)
  !is_digit?(input)
end

# Get an Identifier
#
def get_name
  expected("Name") unless is_alpha?(@look)
  result = @look.upcase
  get_char
  return result
end

# Get a Number
#
def get_num
  expected("Integer") unless is_digit?(@look)
  result = @look
  get_char
  return result
end

def emit(input)
  print "\t" + input
end

def emit_ln(input)
  emit(input)
  print "\n"
end

## Chapter II
def term
  factor
  operations = ['*', '/']
  while (operations.any? { |op| @look == op })
    emit_ln 'MOVE D0, -(SP)'
    operation = case @look
    when '*'
      multiply
    when '/'
      divide
    else
      expected('Mulop')
    end
  end
end

def expression
  term
  emit_ln 'MOVE D0, -(SP)'
  
  operations = ['+', '-']
  while (operations.any? { |op| @look == op })
    operation = case @look
    when '+'
      add
    when '-'
      subtract
    else
      expected('Addop')
    end
  end
end

def add
  match '+'
  term
  emit_ln 'ADD (SP)+, D1'
end

def subtract
  match '-'
  term
  emit_ln 'SUB (SP)+, D0'
  emit_ln 'NEG D0'
end

# Parse and Translate a Math Factor
#
def factor
  emit_ln "MOVE #{get_num},D0"
end

# Recognize and Translate a Multiply
#
def multiply
  match '*'
  factor
  emit_ln 'MULS (SP)+,D0'
end

# Recognize and Translate a Divide
#
def divide
  match '/'
  factor
  emit_ln 'MOVE (SP)+,D1'
  emit_ln 'DIVS D1,D0'
end