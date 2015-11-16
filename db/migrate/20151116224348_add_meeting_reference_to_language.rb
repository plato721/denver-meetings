class AddMeetingReferenceToLanguage < ActiveRecord::Migration
  def change
    add_reference :languages, :meeting, index: true, foreign_key: true
  end
end
