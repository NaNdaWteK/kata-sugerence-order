class Relation

  def initialize
    @relation = Hash.new
  end

  def set_relation(new_order, id)
    @relation[new_order] = id
  end

  def relationship
    @relation
  end

end
