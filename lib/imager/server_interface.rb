require 'openssl'
require 'cgi'
require 'json'

module Imager
  class ServerInterface

    # if file is a class that respond to original_filename (like UploadIO)
    # the file id will be the original_filename.

    # @param  [String]        Collection for save the image
    # @param  [String]        Album for save the image
    # @param  [UploadIO, File, String]  The image file or the path to it.
    # @param  [Hash]          Sizes you want to save. @see https://github.com/guilherme-otran/Imager#sizes-explain
    # @param  [String]        File id. if passed file_id will be this instead of file.original_filename or File.basename(file).
    # @return [void]
    # @raise  [ImagerError]   if some server validation failed.
    # @raise  [ArgumentError] when something with server comunication is wrong
    def self.post(collection, album, file, sizes, file_id = nil)
      raise Imager::ImagerError "File is empty", caller unless file

      if file.is_a?(String)
        raise Imager::ImagerError, "File is not a file", caller unless File.file?(file)
        file = File.new(file)
      end

      query = {}
      query[:collection] = collection
      query[:album]      = album
      query[:sizes]      = sizes

      query[:file_id]    = file_id
      query[:file_id]  ||= file.original_filename if file.respond_to?(:original_filename)
      query[:file_id]  ||= File.basename(file)

      # Remove file extension
      query[:file_id].gsub!(/(\..{3,4})\z/i, '')

      #if (file.respond_to?(:tempfile))
      auth = auth_token(query, file)
      query[:file] = file
      query[:auth] = auth

      return parse(client.post('/post.php', { query: query }))
    end

    def self.delete(collection, album, file_id)
      query = {}
      query[:collection] = collection
      query[:album]      = album
      query[:file_id]    = file_id
      query[:auth]       = auth_token(query)

      return parse(client.post('/delete.php', { query: query }), true)
    end

    def self.client
      unless Imager::ServerClient.base_uri
        Imager::ServerClient.base_uri Imager.base_uri + '/' + Imager.manager_path
      end
      Imager::ServerClient
    end

    private

    def self.parse(response, is_delete = false)
      case response.code
      when 204
        return true
      when 200..299
        parsed =  begin
                    !!JSON.parse(response.body)
                  rescue
                    false
                  end

        return true if parsed
        # Something is wrong with the server
        raise ArgumentError, "The server send an invalid response.", caller
      when 422
        raise ImagerError, response.body, caller
      when 404
        # We are deleting something that doesn't exist
        if (is_delete && response.body == "Cannot find the file.")
          raise ImagerError, response.body, caller
        else
          raise ArgumentError, "The server return an unexpected 404.", caller
        end
      when 401
        # Authentication with the server failed
        raise ArgumentError, "Authentication failed: " + response.body, caller
      else
        raise ArgumentError, "The server returned an error: " + response.body, caller
      end
    end

    def self.auth_token(query, file=nil)
      query_hash = query.clone
      if file
        query_hash[:file_md5]   = Digest::MD5.file(file)
        query_hash[:file_sha1]  = Digest::SHA1.file(file)
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