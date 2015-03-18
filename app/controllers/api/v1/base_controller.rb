#   Copyright (C) 2013-2014 Computer Sciences Corporation
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

module Api
  module V1
    class BaseController < ApplicationController

      protect_from_forgery  with: :null_session

      around_filter :my_filter

      private
      class HttpException < Exception
        attr_reader :code
        def initialize(msg, code)
          super(msg)
          @code = code
        end
      end

      def not_modified(str)
        raise HttpException.new str, 304
      end

      def bad_request(str)
        raise HttpException.new str, 400
      end

      def not_authorized(str)
        raise HttpException.new str, 401
      end

      def forbidden(str)
        raise HttpException.new str, 403
      end

      def not_found(str)
        raise HttpException.new str, 404
      end

      def internal_server_error(str)
        raise HttpException.new str, 500
      end

      def my_filter
        begin
          yield
        rescue HttpException => s
          render json: {error: s.message }, status: s.code
        end
      end
    end
  end
end