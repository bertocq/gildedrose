class Product
  attr_accessor :item
  def initialize(item)
    @item = item
  end

  def sell_in_update
    @item.sell_in -= 1
  end

  def quality_update
    item.quality -= 1 if item.quality > 0
    item.quality -= 1 if item.sell_in < 0 && item.quality > 0
  end

  def update
    sell_in_update
    quality_update
  end
end

class ProductBrie < Product
  def update
    sell_in_update
    quality_update
  end

  def quality_update
    @item.quality += 1 if @item.quality < 50
    @item.quality += 1 if @item.sell_in < 0 && @item.quality < 50
  end
end

class ProductBackstage < Product
  def update
    sell_in_update
    quality_update
  end
  
  def quality_update
    if item.quality < 50
      item.quality += 1
      item.quality += 1 if item.sell_in < 10
      item.quality += 1 if item.sell_in < 5
    end
    item.quality = 0 if item.sell_in < 0
  end
end

class ProductConjured < Product
  def update
    sell_in_update
    quality_update
  end
  
  def quality_update
    if item.quality > 0
      item.quality -= 1
      item.quality -= 1 if item.quality > 0
    end
    if item.sell_in < 0
      if item.quality > 0
        item.quality -= 1
        item.quality -= 1 if item.quality > 0
      end
    end
  end
end

class ProductSulfuras < Product
  def update
  end
end

def update_quality(items)
  items.each do |item|
    product_class = { 'Aged Brie' => ProductBrie,
                      'Backstage passes to a TAFKAL80ETC concert' => ProductBackstage,
                      'Conjured Mana Cake' => ProductConjured,
                      'Sulfuras, Hand of Ragnaros' => ProductSulfuras
                      }[item.name] || Product
    product_class.new(item).update
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
