class Ordinal

  def initialize
    @order = ''
    @minor = ''
    @major = ''
    @detail = ''
    @separator = '.'
  end

  def save(new_order)
    @order = new_order
    @major = get_first_level
    @minor = get_second_level
    @detail = get_third_level
  end

  def order
    @order
  end

  def major
    @major
  end

  def minor
    @minor
  end

  def detail
    @detail
  end

  def get_first_level
    @order.split(@separator)[0]
  end

  def get_second_level
    @order.split(@separator)[1]
  end

  def get_third_level
    @order.split(@separator)[2]
  end

end
