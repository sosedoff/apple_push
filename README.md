# ApplePush

Sinatra-based API service to send Apple Push Notifications (APN)

## Installation

Clone the repo and run:

```
rake install
```

This will get you the gem

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