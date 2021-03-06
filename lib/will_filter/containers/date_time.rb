#--
# Copyright (c) 2011 Michael Berkovich
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

module WillFilter
  module Containers
    class DateTime < WillFilter::FilterContainer
      def self.operators
        [:is, :is_not, :is_after, :is_before]
      end
    
      def validate
        return "Value must be provided" if value.blank?
        return "Value must be a valid date/time (2008-01-01 14:30:00)" if time == nil
      end
    
      def time
        Time.parse(value)
      rescue ArgumentError
        nil
      end
    
      def sql_condition
        return [" #{condition.full_key} = ? ",   time]     if operator == :is
        return [" #{condition.full_key} <> ? ",  time]     if operator == :is_not
        return [" #{condition.full_key} > ? ",   time]     if operator == :is_after
        return [" #{condition.full_key} < ? ",   time]     if operator == :is_before
      end
    end
  end
end