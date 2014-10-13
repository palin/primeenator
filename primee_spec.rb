require_relative "primee"
require 'minitest/autorun'
require 'prime'

class TestPrimeenatorPrime < MiniTest::Unit::TestCase
  def test_take
    assert_equal(described_class.take(20), Prime.take(20))
  end

  def test_nth
    assert_equal(described_class.nth(170), 1013)
  end

  def test_is_prime
    assert_equal(described_class.is_prime?(-10), false)
    assert_equal(described_class.is_prime?(0), false)
    assert_equal(described_class.is_prime?(1), false)
    assert_equal(described_class.is_prime?(2), true)

    assert_equal(described_class.is_prime?(94366396730334173383107353049414959521528815310548187030165936229578960209523421808912459795329035203510284576187160076386643700441216547732914250578934261891510827140267043592007225160798348913639472564715055445201512461359359488795427875530231001298552452230535485049737222714000227878890892901228389026881), true)
    assert_equal(described_class.is_prime?(119432521682023078841121052226157857003721669633106050345198988740042219728400958282159638484144822421840470442893056822510584029066504295892189315912923804894933736660559950053226576719285711831138657839435060908151231090715952576998400120335346005544083959311246562842277496260598128781581003807229557518839), true)
    assert_equal(described_class.is_prime?(103130593592068072608023213244858971741946977638988649427937324034014356815504971087381663169829571046157738503075005527471064224791270584831779395959349442093395294980019731027051356344056416276026592333932610954020105156667883269888206386119513058400355612571198438511950152690467372712488391425876725831041), true)
  end

  private

  def described_class
    Primeenator::Prime
  end
end

class TestPrimeenatorMultiplicator < MiniTest::Unit::TestCase
  def test_calculate
    assert_equal(described_class.calculate(Prime.take(5)), multiplications)
  end

  private

  def multiplications
    [
      [4, 6, 10, 14, 22],
      [6, 9, 15, 21, 33],
      [10, 15, 25, 35, 55],
      [14, 21, 35, 49, 77],
      [22, 33, 55, 77, 121]
    ]
  end

  def described_class
    Primeenator::Multiplicator
  end
end

class TestPrimeenatorCompositor < MiniTest::Unit::TestCase
  def test_extend_multiplications
    assert_equal(described_class.extend_multiplications(multiplications, primes), extended_multiplications)
  end

  private

  def primes
    Prime.take(5)
  end

  def multiplications
    [
      [4, 6, 10, 14, 22],
      [6, 9, 15, 21, 33],
      [10, 15, 25, 35, 55],
      [14, 21, 35, 49, 77],
      [22, 33, 55, 77, 121]
    ]
  end

  def extended_multiplications
    [
      ["*", *primes],
      [2, 4, 6, 10, 14, 22],
      [3, 6, 9, 15, 21, 33],
      [5, 10, 15, 25, 35, 55],
      [7, 14, 21, 35, 49, 77],
      [11, 22, 33, 55, 77, 121]
    ]
  end

  def described_class
    Primeenator::Compositor
  end
end
