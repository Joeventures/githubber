module Githubber
  class PullRequests
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(auth_token)
      @auth = {
          "Authorization" => "token #{auth_token}",
          "User-Agent"    => "HTTParty"
      }
    end

    def get_pull_request(owner, repo, number)
      PullRequests.get("/repos/#{owner}/#{repo}/pulls/#{number}", :headers => @auth)
    end

    def create_pull_request(owner, repo, title, head, base, body = "")
      PullRequests.post("/repos/#{owner}/#{repo}/pulls",
                        :headers => @auth,
                        :body    => {:title => title, :head => head, :base => base, :body => body}.to_json
                            )
    end

    def pull_request_merge(owner, repo, number)
      PullRequests.get("/repos/#{owner}/#{repo}/pulls/#{number}/merge", :headers => @auth)
    end



  end
end