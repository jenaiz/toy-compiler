#!/usr/bin/env ruby
#
#  Created by  on 2012-02-04.
#  Copyright (c) 2012. All rights reserved.

def get_num
  expected 'Integer' unless !is_digit(@look)
  result = ord(@look) - ord('0')
  get_char
  return result
end

def expression
  if is_addop @look
    value = 0
  else
    value = get_num
  end
  while is_addop @look
    emit_ln 'MOVE D0, -(SP)'    
    case @look
    when '+': 
      match '+'
      value = value + get_num
    when '-':
      match '-'
      value = value - get_num
    end
  end
  
  return value
end
