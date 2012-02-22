# ApplePush

Sinatra-based API service to send Apple Push Notifications (APN)

## Why?

The difference between most of other APN daemons/libraries is that
ApplePush provides a simple HTTP API and also could be configured to use
both live and sandbox environments with configurable connections pools.

## Installation

Install via rubybems:

```
gem install apple_push
```

Or clone the repo and run:

```
bundle install
rake install
```

## Usage

Create a YAML configuration file:

```yml
host: 127.0.0.1
port: 27000
  
sandbox:
  cert: path/to/your/certificate.pem
  key: path/to/your/key.pem
  pool: 1
  
live:
  cert: path/to/your/certificate.pem
  key: path/to/your/key.pem
  pool: 1
```

To start server run:

```
apple_push path/to/your/config.yml
```

### Using with foreman

If you want to use apple_push server with foreman, you'll need to create a ```Procfile```:

```
apn: apple_push config/apn.yml
```

## API

ApplePush server provides the following routes to send notifications:

```
POST /live
POST /sandbox
```

Test with curl:

```bash
curl -X POST -d '{"alert":"Test Message"}' "http://localhost:27000/live?token=TOKEN"
```

Also, check out an example with ruby and faraday at ```examples/apple_push_client.rb```

## License

Copyright © 2012 Dan Sosedoff.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.