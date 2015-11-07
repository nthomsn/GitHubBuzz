require 'json'

file = File.read('stars.json')
repos = JSON.parse(file)

words = Hash.new
repos.each do |repo|
  next if repo['description'] == nil

  repo['description'].split(" ").each do |word|
    word.gsub!(",","")
    word.gsub!(".","")
    word.gsub!("/","")
    word.gsub!("-","")
    word.gsub!("&","")
    word = word.downcase
    next if word == ''
    next if word.length == 1

    if words.key? word
      words[word] = words[word]+1
    else
      words[word] = 1
    end
  end
end

blacklist = Array.new
f = File.open("blacklist.txt", "r")
f.each_line do |line|
  blacklist.push(line.strip)
end

words.delete_if {|key| blacklist.include? key }

words.sort_by {|_key, value| value}.each do |word|
  puts word[0] + ',' + word[1].to_s
end
