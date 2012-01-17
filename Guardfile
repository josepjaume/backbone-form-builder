guard :shell do

  watch(/^test\/(.+)_test\.(js|coffee)$/) do |m|
    file = "test/#{m[1]}_test.coffee"
    `mocha "#{file}"` if File.exists?(file)
  end

  watch(/^src\/(.+)\.(js|coffee)$/) do |m|
    file = "test/#{m[1]}_test.coffee"
    `mocha "#{file}"` if File.exists?(file)
  end
end
