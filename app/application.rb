require 'pry'
class Application
  @@items = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    #url = req.path.split("/items/").last.split("").drop(1).join("")
    url = req.path.split("/items/").last
    found_item = @@items.find {|item| item.name == url}

      if req.path.match(/items/)
        if found_item != nil
          resp.write "#{found_item.price}"
          resp.status = 200
        else
          resp.write "Item not found"
          resp.status = 400
        end
      else
        resp.write "Route not found"
        resp.status = 404
      end


    resp.finish
  end
end
