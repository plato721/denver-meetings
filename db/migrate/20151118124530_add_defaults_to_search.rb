class AddDefaultsToSearch < ActiveRecord::Migration
  def change
    change_column :searches, :city, :string, default: "any" 
    change_column :searches, :group_name, :string, default: "any" 
    change_column :searches, :day, :string, default: "any" 
    change_column :searches, :time, :string, default: "any" 
    change_column :searches, :open, :string, default: "any" 
    change_column :searches, :here_and_now, :boolean, default: false
    change_column :searches, :lat, :decimal, default: 39.742043
    change_column :searches, :lng, :decimal, default: -104.991531
    change_column :searches, :city_text, :string, default: "any" 
    change_column :searches, :group_text, :string, default: "any" 
    change_column :searches, :women, :string, default: "show" 
    change_column :searches, :men, :string, default: "show" 
    change_column :searches, :youth, :string, default: "show" 
    change_column :searches, :gay, :string, default: "show" 
    change_column :searches, :access, :string, default: "show" 
    change_column :searches, :non_smoking, :string, default: "show" 
    change_column :searches, :sitter, :string, default: "show" 
    change_column :searches, :spanish, :string, default: "show" 
    change_column :searches, :polish, :string, default: "show" 
    change_column :searches, :french, :string, default: "show" 
  end
end
