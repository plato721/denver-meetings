class FixMissingAddresses < ActiveRecord::Migration[5.2]
  def change
    bad_horse = Meeting.find_by(group_name: 'Four Horsemen*')
    next if bad_horse&.address.present? # already run manually in prod 7-2-19

    york = Address.find_by(address_1: '1311 York St.')
    unknown_club = Address.where('address_1 LIKE ?', '%10576%').first

    bad_horse.update_attributes(address: york)

    mdo = Meeting.where(group_name: 'Mid-day Open')
    mdo.update_all(address_id: unknown_club.id)

    nb = Meeting.where(group_name: "Noon Beginners")
    nb.update_all(address_id: unknown_club.id)

    sk = Meeting.find_by(group_name: "Spiritual Kndrgrtn")
    sk.update_attributes(address: york)

    sh = Meeting.find_by(group_name: "Spearhead")
    sh.update_attributes(address: york)
  end
end
