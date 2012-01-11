guard :shell do
  watch(/^spec\/(.+)spec\.(js|coffee)$/) { |m| `jasmine-node --coffee spec --match "#{m[1]}"`}
  watch(/^src\/(.+)\.(js|coffee)$/) { |m| `jasmine-node --coffee spec --match "#{m[1]}_"`}
end
