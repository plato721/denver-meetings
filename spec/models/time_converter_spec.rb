require 'rails_helper'

RSpec.describe TimeConverter do
  context "AM string" do
    it "converts a zero minute time" do
      raw = "06:00 AM"

      expected = 6.0
      actual = TimeConverter.to_dec(raw)

      expect(actual).to eq(expected)
    end

    it "converts a time with minutes" do
      raw = "8:30 AM"

      expected = 8.5
      actual = TimeConverter.to_dec(raw)

      expect(actual).to eq(expected)
    end
  end

  context "PM string" do
    it "converts a zero minute time" do
      raw = "1:00 PM"

      expected = 13.0
      actual = TimeConverter.to_dec(raw)

      expect(actual).to eq(expected)
    end

    it "converts a time with minutes" do
      raw = "5:45 PM"

      expected = 17.75
      actual = TimeConverter.to_dec(raw)

      expect(actual).to eq(expected)
    end
  end

  context "from decimal" do
    it "converts a morning time" do
      raw = 5.0

      expected = "5:00am"
      actual = TimeConverter.display(raw)

      expect(actual).to eq(expected)
    end

    it "converts a fractional time" do
      raw = 17.75

      expected = "5:45pm"
      actual = TimeConverter.display(raw)

      expect(actual).to eq(expected)
    end
  end

  it "gives time now in decimal format" do
    allow(Time).to receive(:now).and_return(Time.new(2008,6,21, 13,30,0))
    time = Time.now

    expect(TimeConverter.now).to eq(13.5)
  end

end