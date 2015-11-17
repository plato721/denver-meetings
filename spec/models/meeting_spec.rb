require 'rails_helper'

RSpec.describe Meeting, type: :model do
  include_context "codes"
  fixtures :meetings

  before do
    create_formats
    create_features
    create_foci
    create_languages
  end

  it "does not allow duplicate formats" do
    meeting = Meeting.first

    format = Format.first
    expect(meeting.formats.empty?).to be_truthy

    meeting.formats << format
    expect(meeting.formats.count).to eq(1)

    meeting.formats << format
    expect(meeting.formats.count).to eq(1)
  end

  it "does not allow duplicate features" do
    meeting = Meeting.first

    feature = Feature.first
    expect(meeting.features.empty?).to be_truthy

    meeting.features << feature
    expect(meeting.features.count).to eq(1)

    meeting.features << feature
    expect(meeting.features.count).to eq(1)
  end

  it "does not allow duplicate foci" do
    meeting = Meeting.first

    focus = Focus.first
    expect(meeting.foci.empty?).to be_truthy

    meeting.foci << focus
    expect(meeting.foci.count).to eq(1)

    meeting.foci << focus
    expect(meeting.foci.count).to eq(1)
  end

  it "does not allow duplicate languages" do
    meeting = Meeting.first

    language = Language.first
    expect(meeting.languages.empty?).to be_truthy

    meeting.languages << language
    expect(meeting.languages.count).to eq(1)

    meeting.languages << language
    expect(meeting.languages.count).to eq(1)
  end

end
