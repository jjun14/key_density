require 'open-uri'
require 'nokogiri'

class Crawler
  def obtain(url, num_keywords)
    page = Nokogiri::HTML(open(url))
    total_words = 0
    word_count = {}
    content = page.css('p').collect{ |node| node.text }.join(" ").split(" ")

    content.each do |word|
      if word_count.has_key?(word) && word.match(/[A-Za-z]/)
        word_count[word] += 1
      else
        word_count[word] = 1
      end
      total_words += 1
    end

    word_count = word_count.sort_by{|k,v| v}.reverse[0...10]

    word_count.each do |word|
      total_words -= word[1]
    end

    word_count.push(['Other Words', total_words])
    word_count
  end
end