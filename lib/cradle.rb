#!/usr/bin/env ruby

## Chapter I
def init
  @expression = gets.chomp
  @expression = @expression.split(//)
  puts @expression.class
  @number = 0
  get_char
end

# Read New Character From Input Stream
#
def get_char
  @look = @expression[@number]
  @number +=1
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

# Recognize an Alphanumeric
#
def is_al_num(input)
  is_alpha?(input) || is_digit?(input)
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
  token = ""
  while is_al_num(@look)
    token = token + @look.upcase
    get_char
  end
  return token
end

# Get a Number
#
def get_num
  expected("Integer") unless is_digit?(@look)
  value = ""
  while is_digit?(@look)
    value = value + @look
    get_char
  end
  return value
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
    case @look
    when '*': multiply
    when '/': divide
    else expected('Mulop')
    end
  end
end

# Parse and Translate an Expression
#
def expression
  if is_addop @look
    emit_ln 'CLR D0'
  else
    term
  end
  while is_addop @look
    emit_ln 'MOVE D0, -(SP)'    
    case @look
    when '+': add
    when '-': subtract
    else expected('Addop')
    end
  end
end

# Recognize an Addop
#
def is_addop(input)
  ['+', '-'].any? { |op| @look == op }
end

# Recognize and Translate an Add
#
def add
  match '+'
  term
  emit_ln 'ADD (SP)+, D1'
end

# Recognize and Translate a Subtract
#
def subtract
  match '-'
  term
  emit_ln 'SUB (SP)+, D0'
  emit_ln 'NEG D0'
end

# Parse and Translate a Math Factor
#
def factor
  if @look == '(' 
    match '('
    expression
    match ')'
  elsif is_alpha?@look
    ident
  else
    emit_ln "MOVE ##{get_num},D0"
  end
end

#
# Parse and Translate an Identifier 
#
def ident
  name = get_name
  if @look == '('
    match '('
    match ')'
    emit_ln "BSR #{name}"
  else
    emit_ln "MOVE #{name} (PC),D0"
  end
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

# TODO
#   if Look <> CR then Expected('Newline');

def assignment
  @name = get_name
  match '='
  expression
  emit_ln "LEA #{@name} (PC),A0"
  emit_ln 'MOVE D0,(A0)'
end