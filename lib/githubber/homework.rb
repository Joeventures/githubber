module Githubber
  class Homework
    include HTTParty
    base_uri "https://api.github.com"

    def initialize(auth_token)
      @auth = {
          "Authorization" => "token #{auth_token}",
          "User-Agent"    => "HTTParty"
      }
    end

    #create an issue
    def create_issue(owner, repo, options = {})
      Homework.post("/repos/#{owner}/#{repo}/issues",
      :headers => @auth,
      :body    => options.to_json
      )
    end

    #get the teams in an organization
    def get_teams( org )
      teams = Homework.get("/orgs/#{org}/teams", :headers => @auth)
      teams.each do |team|
        puts team['name']
      end
    end

    #get the members of a team
    def list_team_members(team_id)
      members = Homework.get("/teams/#{team_id}/members", :headers => @auth)
      members.each do |member|
        puts member['login']
      end
    end


    #get the contents of a gist
    def get_gist_contents(gist_id)
      gister = Homework.get("/gists/#{gist_id}", :headers => @auth)
      #binding.pry
      gister['files'].each do |file|
        file.each do |x|
          puts x['content']
        end
      end
    end

  end
end