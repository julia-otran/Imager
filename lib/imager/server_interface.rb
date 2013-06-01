require 'openssl'
require 'cgi'

module Imager
  class ServerInterface
    def self.post(collection, album, file, sizes)
      query = {}
      query[:collection] = collection
      query[:album]      = album
      query[:sizes]      = sizes

      auth = auth_token(query, file)
      query[:file] = File.new(file)
      query[:auth] = auth

      return parse(client.post('/post.php', { query: query }))
    end

    def self.delete(collection, album, file_id)
      query = {}
      query[:collection] = collection
      query[:album]      = album
      query[:file_id]    = file_id
      query[:auth]       = auth_token(query)

      return parse(client.post('/delete.php', { query: query }))
    end

    def self.client
      unless ServerClient.base_uri
        ServerClient.base_uri Imager.base_uri + '/' + Imager.manager_path
      end
      ServerClient
    end

    private

    def self.parse(response)
      case response.code
      when 200..299
        return true
      when 400
        raise ArgumentError, response.body, caller
      when 401
        raise Error, "Authentication failed."
      else
        raise Error, "The server returned an error."
      end
    end

    def self.auth_token(query, file=nil)
      query_hash = query.clone
      if file
        query_hash[:file_md5]   = Digest::MD5.file(file)
        query_hash[:file_sha1]  = Digest::SHA1.file(file)
        query_hash[:file_name]  = File.basename(file)
      end

      query_hash = to_query(query_hash)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('md5'), Imager.auth_code, query_hash)
    end

    def self.to_query(hash, namespace=false)
      if(hash.is_a? Hash)
        hash.collect do |k, v|
          to_query(v, namespace ? "#{namespace}[#{k}]" : k)
        end.join '&'
      else
        CGI.escape(namespace.to_s) + "=" + CGI.escape(hash.to_s)
      end
    end
  end
end