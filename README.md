# simple_postmark [![Build Status](https://travis-ci.org/haihappen/simple_postmark.png)](https://travis-ci.org/haihappen/simple_postmark)

simple_postmark makes it easy to send mails via [Postmark](https://postmarkapp.com)™ using Rails's ActionMailer.

## Table of Contents

* [About](#about)
* [Installation](#installation)
* [Usage](#usage)
* [Configuration](#configuration)
* [Testing](#testing)
* [Contributing](#contributing)
* [Copyright](#copyright)

## About

simple_postmark was created because of the lack of the proper Rails API support in the official [postmark-gem](https://github.com/wildbit/postmark-gem). This was back in 2011, the postmark-gem was [updated](https://github.com/wildbit/postmark-rails/issues/17#issuecomment-13761405) to support the Rails API since then. I recently decided to deprecate this gem in favor of the official gem. However, this gem will continue to support all Rails versions until `5.0`.

Tested against Ruby version `>= 1.9.3` up to `=< 2.2.0` and Rails versions `~> 3.0.0` up to `~> 4.1.0`.

## Installation

In your `Gemfile`:

```ruby
group :production do
  gem 'simple_postmark'
end
```

In your `config/environments/production.rb`:

```ruby
config.action_mailer.delivery_method = :simple_postmark
config.action_mailer.simple_postmark_settings = { api_key: '********-****-****-****-************' }
```

## Usage

Just use your standard Rails Mailer:

```ruby
class NotificationMailer < ActionMailer::Base
  def notification
    mail(to: 'ted@himym.tld', from: 'barney@himym.tld', subject: "I'm your bro!") do
      # ...
    end
  end
end
```

And of course you can use standard attachment calls and [Postmark's tags](https://developer.postmarkapp.com/developer-build.html#message-format):

```ruby
class NotificationMailer < ActionMailer::Base
  def notification
    attachments['thebrocode.pdf'] = File.read('thebrocode.pdf')

    mail(to: 'ted@himym.tld', from: 'barney@himym.tld', subject: "I'm your bro!", tag: 'with-attachment') do
      # ...
    end
  end
end
```

## Configuration

* `api_key`: Your Postmark API key. Go to [your Rack](https://postmarkapp.com/servers),
selected the one you want to use and then go to the **Credentials** tab to find your API key.

* `return_response`: In order to receive the response from the Postmark API
– for example, if you want to store ErrorCode or MessageID -
set it to `true`. ([Mail](https://github.com/mikel/mail) which is the base of simple_postmark
expects this option.)

Example how the ErrorCode, MessageID and other values can be received from Postmark:

```ruby
# config/environments/production.rb
config.action_mailer.simple_postmark_settings = { api_key: '********-****-****-****-************', return_response: true }

# your_mailer.rb
response = YourMailer.email.deliver!.parsed_response

response['MessageID']
  # => "b7bc2f4a-e38e-4336-af7d-e6c392c2f817"
response['ErrorCode']
  # => 0
```

## Testing

Testing simple_postmark is, well, simple. ;)

```ruby
# config/environments/test.rb
config.action_mailer.simple_postmark_settings = { api_key: 'POSTMARK_API_TEST', return_response: true }
```

With this setup, it will actually trigger a connection to the Postmark API, but Postmark will never send any emails and nothing will be delivered to your recipients.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

(The MIT license)

Copyright (c) 2011-2015 Mario Uher

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
