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
    page = Nokogiri::HTML(open(profile_url))
    student = {}

    icons = page.css("div.social-icon-container a").collect {|icon| icon.attribute("href").value}

    icons.each do |link|
      if link.include?("twitter")
        student[:twitter] = link
      elsif link.include?("linkedin")
        student[:linkedin] = link
      elsif link.include?("github")
        student[:github] = link
      elsif link.include?(".com")
        student[:blog] = link
      end
    end

    student[:profile_quote] = page.css("div.profile-quote").text
    student[:bio] = page.css("div.description-holder p").text

    student
  end

end
