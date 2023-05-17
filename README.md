# Vonage LeWagon Tokyo Workshop: Sending an SMS using the Messages API

## Pre-requisites

To run this demo application, you will need the following:

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) installed
- A [Vonage Developer](https://developer.vonage.com/sign-up) account

## Running the Demo

1. Clone the repo: `git clone https://github.com/Vonage-Community/workshop-messages-rails-le_wagon_tokyo.git`
2. `cd` into the repo directory and run `bundle install`
3. Copy or rename `.env.dist` to `.env`
    - In the `.env` file, set `VONAGE_API_KEY` and `VONAGE_API_SECRET` using the equivalent credentials from your Vonage Developer account
4. In the [Vonage Dashboard](https://dashboard.nexmo.com/), create a new application and enable it for the Messages API:
    - Set the Application ID from that Vonage Application as `VONAGE_APPLICATION_ID` in the `.env` file
    - Download the Private Key to the root of the Rails application
5. In the repo directory, run `rails s`
6. Navigate to `localhost:3000` and make some Message requests by submitting the form.
    - Try swapping out the `send_with_net_http` invocation on line 9 of the `SmsController` for `send_with_faraday` or `send_with_vonage_sdk`
