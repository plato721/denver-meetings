require 'rails_helper'

RSpec.describe Language, type: :model do
  let(:valid_languages) do
    {Spn: "Spanish",
    Frn: "French",
    Pol: "Polish"}
  end

  it "allows only valid languages" do
    bad_lang = Language.new(code: "G", name: "German")

    expect(bad_lang).to_not be_valid
  end

  it "does not allow duplicate language" do

  end
end
