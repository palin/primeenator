require 'openssl'

module Primeenator
  module Prime
    class << self
      # returns array of [amount] primes
      def take(amount)
        get_primes(amount)
      end


      # returns [number]th prime
      def nth(number)
        get_primes(number).last
      end

      # checks if [number] is prime
      def is_prime?(number)
        miller_rabin_is_prime?(number)
      end

      private

      def get_primes(n)
        primes = []
        i = 2

        while primes.count < n
          primes.push(i) if miller_rabin_is_prime?(i)

          i += 1
        end

        primes
      end

      # miller-rabin primality test
      # [n] - number to check
      # [g] - accuracy of the test, the higher, the more accurate but slower
      def miller_rabin_is_prime?(n, g=100)
        return false if n < 2
        return true if n == 2

        d = n - 1
        s = 0

        while d % 2 == 0
          d /= 2
          s += 1
        end

        g.times do
          a = 2 + rand(n - 4)
          x = OpenSSL::BN::new(a.to_s).mod_exp(d, n)

          next if x == 1 || x == n - 1

          (1..s-1).each do |r|
            x = x.mod_exp(2, n)
            return false if x == 1
            break if x == n - 1
          end

           return false if x != n -1
        end

        true
      end
    end
  end

  module Multiplicator
    # returns array of multiplications of [primes]
    def self.calculate(primes)
      primes = Array(primes)
      multiplications = []

      primes.each do |p|
        row = []

        primes.each { |pp| row.push(p * pp) }

        multiplications.push(row)
      end

      multiplications
    end
  end

  module Compositor
    # adds additional columns and rows to multiplications' array
    # it helps to draw the table later
    def self.extend_multiplications(multiplications, primes)
      primes = Array(primes)
      multiplications.each_with_index.map { |m, i| m.unshift(primes[i]) }
      multiplications.unshift(primes.unshift("*"))
    end
  end

  module Printer
    class << self
      PLUS = "+"
      MINUS = "-"
      DOUBLE_SEPARATOR = "="
      SPACE = " "
      PIPE = "|"

      # prints info about chosen option
      def options(option, argument)
        if option == :n
          puts "Finding first #{argument} primes and their multiplications..."
        elsif option == :p
          puts "Finding #{argument}th prime number multiplications..."
        elsif option == :c
          puts "Checking if #{argument} is a prime..."
        else
          puts "Wrong or unknown parameters"
        end
      end

      # prints table
      def table(multiplications)
        multiplications_row_number = 0
        lines_count = multiplications.count * 2 + 1
        columns_lengths = multiplications.map { |m| column_length(m) }

        lines_count.times do |i|
          if i == 0 || i == 2 || i == lines_count - 1
            puts separator_line(columns_lengths, true)
          elsif i.odd?
            puts numbers_line(columns_lengths, multiplications[multiplications_row_number])
            multiplications_row_number += 1
          elsif i.even?
            puts separator_line(columns_lengths)
          end
        end
      end

      private

      def number_length(n)
        n.to_s.length
      end

      def column_length(numbers)
        numbers.map { |n| number_length(n) }.max
      end

      def separator_line(columns_lengths, double=false)
        line = PLUS
        separator = MINUS
        separator = DOUBLE_SEPARATOR if double == true

        columns_lengths.count.times do |c|
          line += separator * (columns_lengths[c] + 2)
          line += PLUS
          line += PLUS if c == 0
        end

        line
      end

      def numbers_line(columns_lengths, multiplications)
        line = PIPE

        columns_lengths.count.times do |c|
          column_length = columns_lengths[c]
          right_offset = column_length + 1 - number_length(multiplications[c])

          line += SPACE + multiplications[c].to_s
          line += SPACE * right_offset
          line += PIPE
          line += PIPE if c == 0
        end

        line
      end
    end
  end

  module Operations
    def self.start(option, argument)
      Primeenator::Printer.options(option, argument)

      hash = { n: 'take', p: 'nth', c: 'is_prime?' }
      primes = Primeenator::Prime.send(hash[option], argument)
      
      if option == :c 
        puts primes
        return
      end

      multiplications = Primeenator::Multiplicator.calculate(primes)
      extended_table = Primeenator::Compositor.extend_multiplications(multiplications, primes)

      Primeenator::Printer.table(extended_table)
    end
  end
end
