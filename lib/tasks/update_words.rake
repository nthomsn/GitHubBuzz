require 'json'

JSON_LOCATION = 'lib/tasks/stars.json'
BLACKLIST_LOCATION = 'lib/tasks/blacklist.txt'

desc 'Update popular words from GitHub'
task :update_words => :environment do
  file = File.read(JSON_LOCATION)
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
  f = File.open(BLACKLIST_LOCATION, "r")
  f.each_line do |line|
    blacklist.push(line.strip)
  end

  words.delete_if {|key| blacklist.include? key }

  Word.delete_all
  words.keys.each do |word|
    data = Word.new(:name => word, :uses => words[word])
    data.save
  end

end
