module Githubber
  class Issues
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(auth_token)
      @auth = {
          "Authorization" => "token #{auth_token}",
          "User-Agent"    => "HTTParty"
      }
    end

    #comment on an issue
    def issue_comment(owner, repo, issue_number, comment)
      Issues.post(
          "/repos/#{owner}/#{repo}/issues/#{issue_number}/comments",
          :headers => @auth,
          :body    => { :body => comment }.to_json
      )
    end

    #list issues for a repo
    def list_issues(owner,repo, options = {})
      Issues.get(
          "/repos/#{owner}/#{repo}/issues",
          :headers => @auth,
          :body    => options.to_json
      )
    end

    #close an issue
    def close_issue(owner, repo, number)
      Issues.patch(
          "/repos/#{owner}/#{repo}/issues/#{number}",
          :headers => @auth,
          :body    => ({ :state => "closed" }).to_json
      )
    end

  end
end