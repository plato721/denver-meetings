require 'rails_helper'

RSpec.describe Meeting, type: :model do
  include_context "codes"

  before :all do
    Meeting.destroy_all
    create_all_meeting_features
    FactoryGirl.create_list :meeting, 3
  end

  after :all do
    destroy_all_meeting_features
    Meeting.destroy_all
  end

  before :each do
    no_geocode
  end

  it "has formats" do
    meeting = Meeting.first

    format = Format.first
    expect(meeting.formats.empty?).to be_truthy

    meeting.formats << format
    expect(meeting.formats.count).to eq(1)
  end

  it "does not have duplicate formats" do
    meeting = Meeting.first
    format = Format.first

    expect(meeting).to be_valid
    meeting.formats << format
    expect(meeting).to be_valid
    meeting.formats << format
    expect(meeting).to_not be_valid
  end

  it "has features" do
    meeting = Meeting.first

    feature = Feature.first
    expect(meeting.features.empty?).to be_truthy

    meeting.features << feature
    expect(meeting.features.count).to eq(1)
  end

  it "does not have duplicate features" do
    meeting = Meeting.first

    feature = Feature.first
    meeting.features << feature
    expect(meeting).to be_valid

    meeting.features << feature
    expect(meeting).to_not be_valid
  end

  it "has foci" do
    meeting = Meeting.first

    focus = Focus.first
    expect(meeting.foci.empty?).to be_truthy

    meeting.foci << focus
    expect(meeting.foci.count).to eq(1)
  end

  it "does not have duplicate foci" do
    meeting = Meeting.first

    focus = Focus.first
    dup = [focus, focus]

    meeting.foci = dup
    expect(meeting).to_not be_valid
  end

  it "has languages" do
    meeting = Meeting.first

    language = Language.first
    expect(meeting.languages.empty?).to be_truthy

    meeting.languages << language
    expect(meeting.languages.count).to eq(1)
  end

  it "does not have duplicate languages" do
    meeting = Meeting.first
    expect(meeting).to be_valid

    language = Language.first
    meeting.languages << language

    expect(meeting).to be_valid
    meeting.languages << language

    expect(meeting).to_not be_valid
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

  # skipping while swinging to flag
  it "scopes for open/closed" do
    expect(Meeting.open.count).to eq(Meeting.count)
    expect(Meeting.closed.count).to eq(0)

    Meeting.first.update_attribute(:is_closed, true)
    expect(Meeting.closed.count).to eq(1)
    expect(Meeting.open.count).to eq(Meeting.count - 1)
  end
end
