class ApplicationController < ActionController::Base
  include ErrorHandling
  include Authentication
  include Internationalization

end
