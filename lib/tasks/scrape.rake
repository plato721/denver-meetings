

namespace :daccaa do

  url = "http://www.daccaa.org/query.asp"
  page = RestClient.post(url, {
  'txtGroup'=>'',
  'cboDay'=>'0',
  'cboStartTime'=>'All',
  'cboEndTime'=>'All',
  'txtCity'=>'',
  'cboMeetingType'=>'All',
  'cboMeetingFormat'=>'All',
  'cboSpecialMeeting'=>'All',
  'cboDistrict'=>'All',
  'cmdFindMeetings'=>'Find Meetings'
  })

  task :get_data => :environment do
    npage = Nokogiri::HTML(page)
    data = npage.search('//text()').map(&:text).delete_if{|x| x !~ /\w/}
    data = data.map {|ugly| ugly.lstrip} #remove leading whitespace
    binding.pry


  end
end