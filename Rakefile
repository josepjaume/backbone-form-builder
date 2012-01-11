desc "Runs the test suite"
task :default do
  exec "jasmine-node --coffee spec"
end

task :compile do
  if Dir.glob("compiled").length > 1
    exec "rm compiled/"
  end
  exec "coffee -o compiled -c src/*"
end

task :install do
  puts `npm install jasmine-node jsdom backbone jquery`
  puts `npm install coffee-script -g`
end
