require "net/http"

class App < Roda
  plugin :render
  plugin :json
  plugin :request_headers

  route do |r|
    r.root do
      r.redirect "/service"
    end

    r.on "service", String do |type|
      # token would be passed to or recieved by BORG in api call
      token = r.headers["TOKEN"]
      r.is do
        r.get do
          # placeholder api call and HTML fragment
          api_uri = URI("https://jsonplaceholder.typicode.com/users")
          @users = Net::HTTP.get(api_uri)
          @users = JSON.parse(@users)
          fragment = render(type)
          {
            fragment: fragment,
            token: token
          }
        end
      end
    end
  end
end