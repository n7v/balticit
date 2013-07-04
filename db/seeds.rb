#place your seed data to db/seeds

puts "Seeding..."

Dir.glob(Rails.root.join("db", "seeds", "*.rb")).each do |file|
  print "-> #{file} ... "
  load file
  puts "ok"
end

puts "Done"
