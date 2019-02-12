# This was put in place in early 2019 to scrube phone numbers out of existing
# addresses. That is, it gets the phone number, saves it where it should be,
# removes the number and any leading comma from the address, and stores the
# address.
module Meeting
  class ExtractPhone
    class << self
      def extract! meeting
        initial_address = meeting.address_1
        return unless has_phone? initial_address

        phone_part = initial_address.match(phone_regex).to_s
        address_part = scrub_phone_from(initial_address)

        meeting.update_column(:address_1, address_part)
        meeting.update_column(:phone, phone_part)
      end

      def has_phone? address
        address.match phone_regex
      end

      def phone_regex
        MeetingCreator::PhoneExtractor.phone_matcher
      end

      def phone_and_leading_comma_regex
        /(, )?#{phone_regex}/
      end

      def scrub_phone_from address
        phone_and_trimmings = address.match(phone_and_leading_comma_regex).to_s
        address.gsub(phone_and_trimmings, "")
      end
    end
  end
end
