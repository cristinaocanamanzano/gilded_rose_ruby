require 'gilded_rose'

describe GildedRose do
  regular_item_1 = Item.new("item_1", 3, 5)
  regular_item_2 = Item.new("item_2", 1, 3)
  sulfura = Sulfura.new("Sulfuras, Hand of Ragnaros", 10, 10)
  brie = AgedBrie.new("Aged Brie", 10, 15)
  backstage= Backstage.new("Backstage passes to a TAFKAL80ETC concert", 25, 5)
  conjured = Conjured.new("Conjured", 15, 45)
  items = [regular_item_1, regular_item_2, sulfura, brie, backstage, conjured]

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

      context "when update_quality has been run twice" do
        it "reduces quality by 2 when sell in date is negative" do
          gilded_rose.update_quality
          expect(items[1].quality).to eq 0
        end

        it "reduces sell in date by 1 also after 0" do
          expect(items[1].sell_in).to eq -1
        end
      end

      context "when update_quality has been run 12 times" do
       it "quality is never negative" do
         10.times { gilded_rose.update_quality }
         expect(items[0].quality).to eq 0
         expect(items[1].quality).to eq 0
       end
      end
    end

    context "special items" do
       context "when update_quality has been run 12 times" do
         it "sulfura item does not have its quality affected" do
           expect(items[2].sell_in).to eq 10
         end

         it "sulfura item does not have its sellin date affected" do
           expect(items[2].quality).to eq 10
         end

         it "aged brie item has its quality increased instead of reduced" do
           expect(items[3].quality).to eq 27
         end

         it "backstage item´s quality is increased by 1 when sell in date is higher than 10" do
           expect(items[4].quality).to eq 17
         end

         it "conjured item´s quality is reduced by 2 instead of 1 when sell in date is positive" do
           expect(items[5].quality).to eq 21
         end
       end

       context "when update_quality has been run 16 times" do
         it "backstage item´s quality is increased by 2 when sell in date is between 6 and 10" do
           4.times { gilded_rose.update_quality }
           expect(items[4].sell_in).to eq 9
           expect(items[4].quality).to eq 23
         end

         it "conjured item's quality is reduced by 4 instead of 2 when sell in date is negative" do
           expect(items[5].quality).to eq 9
         end
       end

       context "when update_quality has been run 21 times" do
         it "backstage item´s quality is increased by 3 when sell in date is between 6 and 10" do
           5.times { gilded_rose.update_quality }
           expect(items[4].sell_in).to eq 4
           expect(items[4].quality).to eq 35
         end
       end

       context "when update_quality has been run more than 50 times" do
        it "quality never gets higher than 50" do
          50.times { gilded_rose.update_quality }
          expect(items[3].quality).to eq 50
        end

        it "backstage item´s quality is reduced to 0 after sell in date passes" do
          expect(items[4].quality).to eq 0
        end

        it "conjured item's quality does not get lower than 0" do
          expect(items[5].quality).to eq 0
        end
      end
    end
  end
end
