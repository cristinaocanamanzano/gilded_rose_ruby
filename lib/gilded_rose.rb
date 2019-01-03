class GildedRose

  def initialize(items)
    @items = items
  end

  def special_sellin_items
    @special_sellin_items = ["Sulfuras, Hand of Ragnaros"]
  end

  def update_quality()
    @items.each do |item|

      update_regular_item_sellin(item)

      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if quality_positive?(item)
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if quality_lower_than_50?(item)
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if quality_lower_than_50?(item)
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if quality_lower_than_50?(item)
                item.quality = item.quality + 1
              end
            end
          end
        end
      end

      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if quality_positive?(item)
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if quality_lower_than_50?(item)
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  private

  def update_regular_item_sellin(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end
  end

  def quality_positive?(item)
    item.quality > 0
  end

  def quality_lower_than_50?(item)
    item.quality < 50
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
