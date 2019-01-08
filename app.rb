require 'httparty'
require 'jwt'

class App < Roda
  plugin :render
  plugin :json
  plugin :request_headers

  route do |r|
    r.root do
      r.redirect '/service/authenticate'
    end

    r.on 'service' do
      r.is 'authenticate' do
        r.post do
          api_url = ENV['BORG_JWT_AUTH_URL']
          res = HTTParty.post(api_url,
            body: { email: r['email'], password: r['password'], yubikey: r['yubikey'] },
          )
          response.status = 401 unless borg_response_valid?(res)
          res.body
        end
      end
      r.is 'fragment', String do |type|
        r.get do
          if has_valid_token?(r)
            # placeholder api call and HTML fragment
            url = URI('https://jsonplaceholder.typicode.com/users')
            res = HTTParty.get(url, headers: get_request_headers(r))
            @users = JSON.parse(res.body)
            attach_response_headers(res)
            res = render(type)
          else
            response.status = 401
            res = ''
          end
          res
        end
      end
    end
  end

  private

  def attach_response_headers(borg_response)
    response['Content-Type'] = 'text/plain; charset=UTF-8'
    response['_Authorization'] = borg_response.headers['Content-Type']
  end

  def get_request_headers(service_request)
    {
      Authorization: service_request.headers['Authorization']
    }
  end

  def has_valid_token?(stacker_request)
    token = stacker_request.headers['Authorization']
    return false unless token.start_with?('Bearer')
    token = token.delete_prefix!('Bearer ')
    begin
      JWT.decode(token, ENV['JWT_SECRET_KEY'])
      is_valid = true
    rescue StandardError
      is_valid = false
    end
    is_valid
  end

  def borg_response_valid?(borg_response)
    borg_response.code == 200
  end
end