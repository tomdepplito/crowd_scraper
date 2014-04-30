class KickstarterScraper
  require 'nokogiri'
  require 'open-uri'
  BASE_URL = "https://www.kickstarter.com/discover/advanced?sort=end_date"

  def self.scrape(params={})
    @target_url = BASE_URL + params.to_query
    @doc = Nokogiri::HTML(open(@target_url))
    binding.pry
    process_results
  end

  def self.process_results
    @doc.css('.project-card-wrap').each do |element|
      stats = element.css('.project-stats')
      return if stats.css('li').css('.last').text[/\w{1,}/] == "Funded"
      metadata = element.css('.project-meta')
      project = Project.new
      project.name = element.css('.project-card').css('.bbcard_name').text #fix this
      project.link = "http/kickstarter.com/" + element.css('a')[1].attributes['href'].value
      project.percent_funded = stats.css('li').css('.first').text[/^\d{1,}\%$/].gsub(/\%/, "")
      project.amount_pledged = stats.css('li').css('.pledged').text[/\d{1,},{0,}/].gsub(/\W/, "").to_i
      project.last_time_scraped = Time.now
    end
  end
end
