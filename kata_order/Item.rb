require 'digest/md5'
class Item

  def initialize(type)
    @id = Digest::MD5.hexdigest(Time.now.utc.to_s + Time.now.utc.nsec.to_s + type)
    @type = type
  end

  def type
    @type
  end

  def id
    @id
  end

end
