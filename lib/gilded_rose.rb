class GildedRose

  def initialize(items)
    @items = items
  end

  def special_sellin_items
    @special_sellin_items = ["Sulfuras, Hand of Ragnaros"]
  end

  def special_quality_items
    @special_quality_items = ["Sulfuras, Hand of Ragnaros", "Aged Brie", "Backstage passes to a TAFKAL80ETC concert", "Conjured"]
  end

  def update_quality()
    @items.each do |item|
      update_regular_item_sellin(item) unless special_sellin_items.include?(item.name)
      reduce_regular_item_quality(item) unless special_quality_items.include?(item.name)
      change_aged_brie_quality(item)
      change_backstage_quality(item)
    end
  end

  private

  def update_regular_item_sellin(item)
      item.sell_in = item.sell_in - 1
  end

  def reduce_regular_item_quality(item)
    if quality_positive?(item)
      if sellin_positive?(item)
        item.quality = item.quality - 1
      else
        item.quality = item.quality - 2
      end
    end
  end

  def sellin_positive?(item)
    item.sell_in >= 0
  end

  def quality_positive?(item)
    item.quality > 0
  end

  def quality_lower_than_50?(item)
    item.quality < 50
  end

  def increase_quality_by_1(item)
    item.quality = item.quality + 1
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
end
