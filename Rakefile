desc "Runs the test suite"
task :default => :compile do
  files = Dir.glob("test/**/*_test.coffee")
  exec "mocha --reporter dot #{files.join " "}"
end

task :compile do
  files = Dir.glob("src/**/*.coffee").reverse
  `coffee --lint --join compiled/backbone_form_builder.js --compile --output compiled #{files.join(" ")}`
  if File.exists?('compiled/backbone_form_builder.min.js')
    `rm compiled/backbone_form_builder.min.js`
  end
  `yuicompressor -o 'compiled/backbone_form_builder.min.js' 'compiled/backbone_form_builder.js' --type js`
  puts "Compiled 'backbone_form_builder.min.js'"
end

task :install do
  puts `npm install sinon yui3 jsdom underscore jquery expect.js`
  puts `npm install -g mocha coffee-script`
  puts `brew install yuicompressor`
end
