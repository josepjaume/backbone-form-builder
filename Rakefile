desc "Runs the test suite"
task :default => :compile do
  files = Dir.glob("test/**/*_test.coffee")
  exec "mocha --reporter dot #{files.join " "}"
end

task :compile do
  if Dir.glob("compiled/*").length > 1
    `rm compiled/*`
  end
  `coffee --lint --join compiled/backbone_form_builder.js --compile --output compiled src/*`
  Dir['compiled/*.js'].each do |file|
    file =~ /(.+)\.js/
    `yuicompressor -o '#{$1}.min.js' '#{file}' --type js`
    puts "Compiled '#{$1}.min.js'"
  end
end

task :install do
  puts `npm install sinon yui3 jsdom underscore jquery expect.js`
  puts `npm install -g mocha coffee-script`
  puts `brew install yuicompressor`
end
