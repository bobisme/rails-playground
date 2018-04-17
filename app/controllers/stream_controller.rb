require 'csv'
require 'http'

class StreamController < ApplicationController
  include ActionController::Live

  def enumerator
    file_name = "transactions.csv"
    headers["Content-Type"] = "text/plain"
    headers["Content-Disposition"] = "attachment; filename=\"#{file_name}\""
    headers["Cache-Control"] ||= "no-cache"
    headers.delete("Content-Length")
    headers['X-Accel-Buffering'] = 'no'

    self.response_body = Enumerator.new do |res|
      csv = CSV.new(res)
      csv << ['A', 'B']
      sleep 1
      csv << [1, 2]
      sleep 1
      csv << [3, 4]
    end
  end

  def proxy
    proxy_response = HTTP.get("http://localhost:3000/stream/enumerator")
    proxy_headers = proxy_response.headers.to_h
    bad_headers = %w(
      Connection X-Frame-Options X-Request-Id X-Runtime X-Xss-Protection
      X-Content-Type-Options Transfer-Encoding
    )
    bad_headers.each { |header| proxy_headers.delete(header) }
    proxy_headers.each { |k, v| headers[k] = v }

    self.response_body = Enumerator.new do |yielder|
      while (chunk = proxy_response.readpartial)
        yielder << chunk
      end
    end
  end

  def early
    # must include ActionController::Live in the controller
    response.stream.write 'OK'
    response.stream.close
    p 'TO SLEEP'
    sleep 5
    p 'SLEPT'
  end
end
