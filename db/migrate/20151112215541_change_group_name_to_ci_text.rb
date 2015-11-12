class ChangeGroupNameToCiText < ActiveRecord::Migration
  def change
    enable_extension 'citext'

    change_column :meetings, :group_name, :citext
  end
end
