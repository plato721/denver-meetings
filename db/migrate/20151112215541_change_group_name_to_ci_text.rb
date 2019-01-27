class ChangeGroupNameToCiText < ActiveRecord::Migration[4.2]
  def change
    enable_extension 'citext'

    change_column :meetings, :group_name, :citext
  end
end
