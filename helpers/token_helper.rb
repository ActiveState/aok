module TokenHelper

  # Utility method for parsing an OAuth token from its type.
  def parse_oauth_token(token, token_type)
    if token.nil?
      raise Aok::Errors::AokError.new('Missing Parameter', "'token' parameter must be provided")
    end

    if token_type.nil?
      raise Aok::Errors::AokError.new('Missing Parameter', "'token_type' parameter must be provided")
    end

    # Load up the required token by the provided token_type
    case token_type
      when 'access_token'
        parsed_token = AccessToken.find_by_token(token)
      when 'refresh_token'
        parsed_token = RefreshToken.find_by_token(token)
      else
        raise Aok::Errors::AokError.new('Invalid Parameter', "'token_type' must be either 'access_token' or 'refresh_token'")
    end

    if parsed_token.nil?
      raise Aok::Errors::NotFound.new
    end

    # Specify if the token is currently active or not
    # Token is active unless it has been revoked or has expired.
    # xxx: Move this to the oauth_token model
    active = true
    if parsed_token.revoked
      active = false
    elsif parsed_token.expires_in <= 0
      active = false
    end
    parsed_token[:active] = active

    parsed_token
  end
end