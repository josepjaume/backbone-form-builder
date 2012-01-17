guard :shell do
  watch(/^test\/(.+)_test\.(js|coffee)$/) { |m| `mocha "test/#{m[1]}_test.coffee"`}
  watch(/^src\/(.+)\.(js|coffee)$/) { |m| `mocha "test/#{m[1]}_test.coffee"`}
end
