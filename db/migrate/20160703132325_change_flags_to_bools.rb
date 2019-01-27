class ChangeFlagsToBools < ActiveRecord::Migration[4.2]
  def change
    add_column :meetings, :closed, :boolean, default: false
    add_column :meetings, :men, :boolean, default: false
    add_column :meetings, :women, :boolean, default: false
    add_column :meetings, :gay, :boolean, default: false
    add_column :meetings, :young_people, :boolean, default: false
    add_column :meetings, :speaker, :boolean, default: false
    add_column :meetings, :step, :boolean, default: false
    add_column :meetings, :big_book, :boolean, default: false
    add_column :meetings, :grapevine, :boolean, default: false
    add_column :meetings, :traditions, :boolean, default: false
    add_column :meetings, :candlelight, :boolean, default: false
    add_column :meetings, :beginners, :boolean, default: false
    add_column :meetings, :asl, :boolean, default: false
    add_column :meetings, :accessible, :boolean, default: false
    add_column :meetings, :non_smoking, :boolean, default: false
    add_column :meetings, :sitter, :boolean, default: false
    add_column :meetings, :spanish, :boolean, default: false
    add_column :meetings, :french, :boolean, default: false
    add_column :meetings, :polish, :boolean, default: false
  end
end
