class Base

  INITIAL_PARENT_ORDER = '0.0.0'

  def initialize
    @keys = [INITIAL_PARENT_ORDER]
    @separator = '.'
  end

  def add_order(new_order)
    @keys.push(new_order)
  end

  def keys_order
    return @keys
  end

  def last_major
    major = []
    @keys.each do |element|
      order = element.split(@separator)[0].to_i
      major <<  order
    end
    return major.max
  end

  def last_minor(major)
    minor = []
    minor = @keys.map { |item| item.split(@separator)[1].to_i if (major == item.split(@separator)[0].to_i) }.compact
    return minor.max
  end

  def last_detail(major, minor)
    detail = []
    detail = @keys.map { |item| item.split(@separator)[1].to_i if (minor == item.split(@separator)[1].to_i && major == item.split(@separator)[0].to_i) }.compact
    return detail.max
  end

  def sugerence(parent_order)
    major = parent_order.split(@separator)[0]
    minor = parent_order.split(@separator)[1]
    detail = parent_order.split(@separator)[2]
    return (last_major + 1).to_s + @separator + minor + @separator + detail if( major.to_i == 0 )
    return major + @separator + (last_minor(major.to_i) + 1).to_s + @separator + detail if( minor.to_i == 0 )
    return major + @separator + minor + @separator + (last_detail(major.to_i, minor.to_i) + 1).to_s if( detail.to_i == 0 )
  end

end
