require 'rack/proxy'
class SimpleProxy < Rack::Proxy

  PROXY_URL = 'google.com'

  def perform_request(env)
    env["HTTP_HOST"] = PROXY_URL
    super(env)
  end

  def rewrite_response(triplet)
    status, headers, body = triplet

    # if you proxy depending on the backend, it appears that content-length isn't calculated correctly
    # resulting in only partial responses being sent to users
    # you can remove it or recalculate it here

    triplet
  end
end