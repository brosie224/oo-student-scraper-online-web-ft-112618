require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper

  attr_accessor :students

  def self.scrape_index_page(index_url)
    page = Nokogiri::HTML(open(index_url))

    students = []

    page.css("div.student-card").each do |student|
      name = student.css("h4.student-name").text
      location = student.css("p.student-location").text
      profile_url = student.css("a").attribute("href").value
    students << {name: name, location: location, profile_url: profile_url}
    end

    students
  end

  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

  end

end

 Scraper.scrape_profile_page("./fixtures/student-site/index.html")
