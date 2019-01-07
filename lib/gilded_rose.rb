class GildedRose

  def initialize(items)
    @items = items
  end

  def special_quality_items
    @special_quality_items = ["Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Conjured"]
  end

  def update_quality()
    @items.each do |item|
      item.update_sell_in
      item.update_quality unless special_quality_items.include?(item.name)
      change_special_items(item)
    end
  end

  private

  def sellin_positive?(item)
    item.sell_in > 0
  end

  def quality_positive?(item)
    item.quality > 0
  end

  def quality_lower_than_50?(item)
    item.quality < 50
  end

  def change_aged_brie_quality(item)
    if item.name == "Aged Brie" && quality_lower_than_50?(item)
      item.quality = item.quality + 1
    end
  end

  def change_backstage_quality(item)
    if item.name == "Backstage passes to a TAFKAL80ETC concert" && quality_lower_than_50?(item)
      case item.sell_in
      when 11 .. (1.0/0.0)
        item.quality = item.quality + 1
      when 6 .. 10
        item.quality = item.quality + 2
      when 1 .. 5
        item.quality = item.quality + 3
      when 0
        item.quality = 0
      end
    end
  end

  def change_conjured_quality(item)
    if item.name == "Conjured"
      if item.quality < 2
        item.quality = 0
      elsif item.quality >= 2 && sellin_positive?(item)
        item.quality = item.quality - 2
      else
        item.quality = item.quality - 4
      end
    end
  end

  def change_special_items(item)
    change_aged_brie_quality(item)
    change_backstage_quality(item)
    change_conjured_quality(item)
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
end

class Sulfura < Item
  def update_sell_in
      @sell_in = @sell_in
  end

  def update_quality
    @quality = quality
  end
end
