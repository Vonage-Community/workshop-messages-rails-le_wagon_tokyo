class SmsController < ApplicationController
  def index; end

  def send_sms
    number = params[:number]
    message = params[:message]

    begin
      send_with_net_http(number, message)
      redirect_to '/', notice: "Your message was sent"
    rescue => exception
      redirect_to '/', alert: "Sorry, there was a problem"
    end
  end

  private

  def send_with_net_http(number, message)
    uri = URI('https://api.nexmo.com')

    uri.path = '/v1/messages/'

    body = {
      to: number,
      from: 'Vonage',
      channel: 'sms',
      message_type: 'text',
      text: message + ' from Net::HTTP'
    }.to_json

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => 'Basic ' + basic_authentication
    }

    response = Net::HTTP.post(uri, body, headers)

    raise StandardError unless response.code == '202'
  end

  def send_with_faraday(number, message)
    connection = Faraday.new(
      url: 'https://api.nexmo.com',
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => 'Basic ' + basic_authentication
      }
    )

    response = connection.post('/v1/messages/') do |request|
      request.body = {
        to: number,
        from: 'Vonage',
        channel: 'sms',
        message_type: 'text',
        text: message + ' from Faraday'
      }.to_json
    end

    raise StandardError unless response.status == 202
  end

  def send_with_vonage_sdk(number, message)
    client = Vonage::Client.new(application_id: ENV['VONAGE_APPLICATION_ID'], private_key: ENV['VONAGE_PRIVATE_KEY_PATH'])

    sms = Vonage::Messaging::Message.sms(message: message + ' from SDK')

    client.messaging.send(to: number, from: "Vonage", **sms)
  end

  def basic_authentication
    Base64.encode64("#{ENV['VONAGE_API_KEY']}:#{ENV['VONAGE_API_SECRET']}")
  end
end
