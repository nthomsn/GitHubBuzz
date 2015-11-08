require 'json'

JSON_LOCATION = 'lib/tasks/stars.json'
BLACKLIST_LOCATION = 'lib/tasks/blacklist.txt'

desc 'Update popular words from GitHub'
task :update_words => :environment do
  file = File.read(JSON_LOCATION)
  repos = JSON.parse(file)

  words = Hash.new
  Repo.delete_all
  repos.each do |repo|
    next if repo['description'] == nil
    repo_in_db = Repo.new(:name => repo['full_name'], :description => repo['description'])
    repo_in_db.save

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
        words[word] = words[word].push(repo['full_name'])
      else
        words[word] = [repo['full_name']]
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
    word_in_db = Word.new(:name => word, :uses => words[word].size)
    words[word].each do |repo_name|
      word_in_db.repos << Repo.find_by(:name => repo_name)
    end
    word_in_db.save
  end

end
