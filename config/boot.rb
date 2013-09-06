require 'bundler'

Bundler.require(:default)
require 'sinatra/base'

%W{
  lib/aok/errors
  lib/aok/security_context
  lib/aok/model_authorities_methods
  lib/rack_port_monkeypatch
  lib/omniauth/strategies/identity
  lib/omniauth/form
  lib/active_record_session_store
  lib/active_record_openid_store/lib/openid_ar_store
  lib/database_reconnect
  lib/secure_token
  lib/oauth2_token

  config/config

  helpers/application_helper
  helpers/current_user_helper
  helpers/error_handling_helper

  controllers/application_controller
  controllers/openid_controller
  controllers/users_controller
  controllers/logins_controller
  controllers/uaa_controller

  models/identity
  models/session
  models/client
  models/access_token

}.each{|lib|require File.expand_path('../../'+lib, __FILE__)}

#FIXME remove when ruby-openid gem updated with this fix
# https://github.com/openid/ruby-openid/pull/53
require_relative '../lib/ruby_openid_google_apps_monkeypatch'


require_relative 'ensure_identities'
require_relative 'ensure_clients'
