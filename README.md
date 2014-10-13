primeenator
===========

`./primee -h #Help - list of parameters`
`./primee -n N #Finding N first primes and printing their multiplications in a table.`
`./primee -p N #Gets Nth prime multiplication`
`./primee -c N #Check if N is a prime number.`
`ruby primee_spec.rb #to start tests with minitest`

1. User input
  - list of available parameters (help option)
  - only integers

2. Calculations
  - prime number algorithm (Miller and Rabin algorithm)
  - openssl library for big numbers
  - modularity:
    - module for calculations
    - module for drawings

3. Output
  - table shape
  - different amount of rows/columns, but always squared
  - different length of numbers