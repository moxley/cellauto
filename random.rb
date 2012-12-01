class NewScience
  attr_accessor :m, :m2, :rule

  C0 = 0
  C1 = 1
  CHARACTERS = [C0, C1]

  def initialize(rule)
    @rule = rule
  end

  def setup
    @m = Array.new(179)
    @m2 = Array.new(m.length)
    m.length.times do |i|
      #m[i] = CHARACTERS[rand(CHARACTERS.length)]
      m[i] = C0
    end
    m[m.length / 2] = C1
  end

  # Convert an array of bits (e.g., [0, 1, 0]), into the digits of a binary number
  def bits_to_binary(bits)
    value = 0
    bits.reverse.each_with_index do |p_value, i2|
      or_value = p_value << i2
      value |= or_value
    end
    value
  end

  def calc_pixel(rule, parents_value)
    out_value = (rule & (1 << parents_value)) > 0 ? 1 : 0
  end

  def run
    setup
    80.times.map do
      puts m.map { |v| v == 0 ? '0' : ' ' }.join('')
      m.each_index do |i|
        parents = (m[i-1] || 0), m[i], (m[i+1] || 0)
        parents_value = bits_to_binary(parents)
        out_value = calc_pixel(rule, parents_value)
        m2[i] = out_value
      end
      old_m = m
      @m = m2
      @m2 = old_m
    end
  end
end

255.times do |rule|
  puts "RULE #{rule}:"
  ns = NewScience.new(rule)
  ns.run
end
