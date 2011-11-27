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

def get_name
  expected("Name") unless is_alpha?(@look)
  get_char
end

def get_num
  expected("Integer") unless is_digit?(@look)
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
get_name
get_num