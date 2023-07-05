require File.join(File.dirname(__FILE__), 'spec_helper')
require File.join(File.dirname(__FILE__), '../gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context 'for Backstage passes to a TAFKAL80ETC concert' do
      subject(:item_quality) { items.first.quality }
      let(:items) { [Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in, quality)] }

      before do
        GildedRose.new(items).update_quality
      end

      context 'when item quality if lower than 50 and the sell in price is under 11' do
        let(:expected_quality) { 22 }
        let(:sell_in) { 8 }
        let(:quality) { 20 }

        it 'updates the quality' do
          expect(item_quality). to eq(expected_quality)
        end
      end

      context 'when item quality if lower than 50 and the sell in price is under 6' do
        let(:expected_quality) { 23 }
        let(:sell_in) { 5 }
        let(:quality) { 20 }
        
        it 'updates the quality' do
          expect(item_quality). to eq(expected_quality)
        end
      end

      context 'when sell in price is under 0' do
        let(:expected_quality) { 0 }
        let(:sell_in) { -1 }
        let(:quality) { 20 }
        
        it 'updates the quality' do
          expect(item_quality). to eq(expected_quality)
        end
      end
    end

    context 'for an Aged Brie' do
      subject(:item_quality) { items.first.quality }
      let(:items) { [Item.new("Aged Brie", sell_in, quality)] }

      before do
        GildedRose.new(items).update_quality
      end

      context 'when the quality is lower than 50' do
        let(:expected_quality) { 22 }
        let(:sell_in) { -1 }
        let(:quality) { 20 }
        
        it 'updates the quality' do
          expect(item_quality). to eq(expected_quality)
        end
      end
    end

    context 'for anything else other than Aged Brie, Backstage passes or Sulfuras, Hand of Ragnaros' do
      subject(:item_quality) { items.first.quality }
      let(:items) { [Item.new("Unknown", sell_in, quality)] }

      before do
        GildedRose.new(items).update_quality
      end

      context 'when sell in price is under 0 and the quality is greater than 0' do
        let(:expected_quality) { 18 }
        let(:sell_in) { -1 }
        let(:quality) { 20 }
        
        it 'updates the quality' do
          expect(item_quality). to eq(expected_quality)
        end
      end
    end
  end

end
