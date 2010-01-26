class Bignum < Integer

  # unary operators

  def ~
    Ruby.primitive :bignum_invert
    raise PrimitiveFailure, "Bignum#~ primitive failed"
  end

  def -@
    Ruby.primitive :bignum_neg
    raise PrimitiveFailure, "Bignum#-@ primitive failed"
  end

  # binary math operators

  def +(o)
    Ruby.primitive :bignum_add
    redo_coerced :+, o
  end

  def -(o)
    Ruby.primitive :bignum_sub
    redo_coerced :-, o
  end

  def *(o)
    Ruby.primitive :bignum_mul
    redo_coerced :*, o
  end

  # this method is aliased to / in core
  # see README-DEVELOPERS regarding safe math compiler plugin
  def divide(o)
    Ruby.primitive :bignum_div
    super(o)
  end

  def divmod(other)
    Ruby.primitive :bignum_divmod
    redo_coerced :divmod, other
  end

  def mod_primitive(other)
    Ruby.primitive :bignum_mod
    raise PrimitiveFailure, "primitive failed"
  end

  # bitwise binary operators

  def &(o)
    Ruby.primitive :bignum_and
    super(o)
  end

  def |(o)
    Ruby.primitive :bignum_or
    super(o)
  end

  def ^(o)
    Ruby.primitive :bignum_xor
    super(o)
  end

  def <<(o)
    Ruby.primitive :bignum_left_shift
    super(o)
  end

  def >>(o)
    Ruby.primitive :bignum_right_shift
    super(o)
  end

  def **(o)
    Ruby.primitive :bignum_pow
    redo_coerced :**, o
  end

  # comparison operators

  def <(other)
    Ruby.primitive :bignum_lt
    b, a = math_coerce other, :compare_error
    a < b
  end

  def <=(other)
    Ruby.primitive :bignum_le
    b, a = math_coerce other, :compare_error
    a <= b
  end

  def >(other)
    Ruby.primitive :bignum_gt
    b, a = math_coerce other, :compare_error
    a > b
  end

  def >=(other)
    Ruby.primitive :bignum_ge
    b, a = math_coerce other, :compare_error
    a >= b
  end

  def ==(o)
    Ruby.primitive :bignum_equal
    super(o)
  end

  def <=>(other)
    Ruby.primitive :bignum_compare
    super(other)
  end

  # conversions

  def self.from_float(value)
    Ruby.primitive :bignum_from_float
    raise PrimitiveFailure, "Bignum.from_float primitive failed"
  end

  def coerce(other)
    Ruby.primitive :bignum_coerce
    super other
  end

  def to_f
    Ruby.primitive :bignum_to_float
    raise PrimitiveFailure, "Bignum#to_f primitive failed"
  end

  def radix_to_s(radix)
    Ruby.primitive :bignum_to_s
    raise PrimitiveFailure, "Bignum#radix_to_s primitive failed"
  end

  def to_s(radix=10)
    unless radix.between?(2, 36)
      raise ArgumentError, 'base must be between 2 and 36'
    end
    radix_to_s(radix)
  end

  def inspect
    radix_to_s(10)
  end

  def size
    Ruby.primitive :bignum_size
    raise PrimitiveFailure, "Bignum#size primitive failed"
  end
end
