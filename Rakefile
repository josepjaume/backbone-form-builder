desc "Runs the test suite"
task :default do
  exec "jasmine-node --coffee spec"
end

task :compile do
  if Dir.glob("compiled/*").length > 1
    `rm compiled/*`
  end
  `coffee -o compiled -c src/*`
  Dir['compiled/*.js'].each do |file|
    file =~ /(.+)\.js/
    `yuicompressor -o '#{$1}.min.js' '#{file}' --type js`
    puts "Compiled '#{$1}.min.js'"
  end
end

task :install do
  puts `npm install sinon yui3 jsdom underscore jquery`
  puts `npm install -g jasmine-node coffee-script`
  puts `brew install yuicompressor`
end
