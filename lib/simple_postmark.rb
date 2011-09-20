require 'active_support/core_ext/object/blank'
require 'active_support/inflector/methods'
require 'json'
require 'mail'
require 'typhoeus'

module SimplePostmark  
  require 'simple_postmark/mail_ext/message'
  require 'simple_postmark/mail_ext/part'
  
  require 'simple_postmark/delivery_method'
  
  require 'simple_postmark/railtie' if defined?(Rails)
end