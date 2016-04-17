require 'rails_helper'

RSpec.describe Meeting, type: :model do
  include_context "codes"
  fixtures :meetings
  fixtures :raw_meetings

  before do
    create_formats
    create_features
    create_foci
    create_languages
  end

  it "has formats" do
    meeting = Meeting.first

    format = Format.first
    expect(meeting.formats.empty?).to be_truthy

    meeting.formats << format
    expect(meeting.formats.count).to eq(1)
  end

  it "has features" do
    meeting = Meeting.first

    feature = Feature.first
    expect(meeting.features.empty?).to be_truthy

    meeting.features << feature
    expect(meeting.features.count).to eq(1)
  end

  it "has foci" do
    meeting = Meeting.first

    focus = Focus.first
    expect(meeting.foci.empty?).to be_truthy

    meeting.foci << focus
    expect(meeting.foci.count).to eq(1)
  end

  it "has languages" do
    meeting = Meeting.first

    language = Language.first
    expect(meeting.languages.empty?).to be_truthy

    meeting.languages << language
    expect(meeting.languages.count).to eq(1)
  end

  it "is visible by default" do
    meeting = Meeting.first

    expect(meeting.visible?).to be_truthy
  end

  it "scopes for visible" do
    meeting = Meeting.first
    meeting.update_attribute(:visible, false)

    found = Meeting.visible
    expect(found.all? { |m| m.visible? }).to be_truthy
    expect(found.count).to eq(Meeting.count - 1)
  end
end
