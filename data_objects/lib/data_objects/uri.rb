require 'addressable/uri'

module DataObjects
  URI = Struct.new(:scheme, :user, :password, :host, :port, :specified_port, :path, :query, :fragment) 

  class URI
    def self.parse(uri)
      uri = Addressable::URI::parse(uri) unless uri.is_a?(Addressable::URI)
      self.new(uri.scheme, uri.user, uri.password, uri.host, uri.port, uri.specified_port, uri.path, uri.query, uri.fragment)
    end

    def to_s
      string = ""
      string << "#{scheme}://"       if scheme
      if user
        string << "#{user}"
        string << ":#{password}"     if password
        string << "@"
      end
      string << "#{host}"            if host
      string << ":#{specified_port}" if specified_port
      string << path.to_s
      string << "?#{query}"          if query
      string << "##{fragment}"       if fragment
      string
    end
  end
end