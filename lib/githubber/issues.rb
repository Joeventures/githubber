module Githubber
  class Issues
    include HTTParty
    base_uri "https://api.github.com"
  end
end