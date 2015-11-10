class ErrorController < ApplicationController
  def unauthorized
    render template: 'error/unauthorized', layout: 'layouts/application', status: 403
  end
end
