require 'gilded_rose'

describe GildedRose do
  regular_item_1 = Item.new("item_1", 3, 5)
  regular_item_2 = Item.new("item_2", 1, 3)

  items = [regular_item_1, regular_item_2]

  subject(:gilded_rose) { described_class.new(items)}

  describe "#update_quality" do
    context "regular items" do
      context "when update_quality has been run once" do
        it "reduces sell in date by 1" do
          gilded_rose.update_quality
          expect(items[0].sell_in).to eq 2
          expect(items[1].sell_in).to eq 0
        end

        it "reduces quality by 1 when sell in date is positive" do
          expect(items[0].quality).to eq 4
        end
      end
    end
  end

end
