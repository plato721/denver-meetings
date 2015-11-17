class AddColumnsToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :city_text, :string
    add_column :searches, :group_text, :string
    add_column :searches, :women, :string
    add_column :searches, :men, :string
    add_column :searches, :youth, :string
    add_column :searches, :gay, :string
    add_column :searches, :access, :string
    add_column :searches, :non_smoking, :string
    add_column :searches, :sitter, :string
    add_column :searches, :spanish, :string
    add_column :searches, :polish, :string
    add_column :searches, :french, :string
  end
end
