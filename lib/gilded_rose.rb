class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      item.update_sell_in
      item.update_quality
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end

  def update_sell_in
      @sell_in -= 1
  end

  def update_quality
    if quality_positive?
      if sellin_positive?
        @quality -= 1
      elsif @quality >= 2
        @quality -= 2
      else
        @quality = 0
      end
    end
  end

  private

  def sellin_positive?
    @sell_in > 0
  end

  def quality_positive?
    @quality > 0
  end

  def quality_lower_than_50?
    @quality < 50
  end
end

class Sulfura < Item
  def update_sell_in
    @sell_in = @sell_in
  end

  def update_quality
    @quality = @quality
  end
end

class AgedBrie < Item
  def update_quality
    if quality_lower_than_50? then @quality += 1 end
  end
end

class Backstage < Item
  def update_quality
    if quality_lower_than_50?
      case @sell_in
      when 11 .. (1.0/0.0)
        @quality += 1
      when 6 .. 10
        @quality += 2
      when 1 .. 5
        @quality += 3
      when 0
        @quality = 0
      end
    end
  end
end


class Conjured < Item
  def update_quality
    if @quality < 2
      @quality = 0
    elsif @quality >= 2 && sellin_positive?
      @quality -= 2
    else
      @quality -= 4
    end
  end
end
