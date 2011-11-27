#!/usr/bin/env ruby

def get_char
  @look = gets.chomp
end

def error(text)
  puts "\nError: " + text
end

def expected(text)
  abort(text + " Expected")
end

def match(input)
  @look == input ? get_char : expected("'" + input.to_s + "'")
end

def is_digit?(input)
    !!Float(input) rescue false
end

def is_alpha?(input)
  return !is_digit?(input)
end

def get_name(input)
  expected("Name") unless is_alpha?(input)
  get_char
end

def get_num(input)
  expected("Integer") unless is_digit?(input)
  get_char
end

def emit(input)
  print "\t" + input
end

def emit_ln(input)
  emit(input)
  print "\n"
end

def init
  get_char
end

init