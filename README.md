# ApplePush

Sinatra-based API service to send Apple Push Notifications (APN)

## Installation

Clone the repo and run:

```
rake install
```

This will get you the gem

## Usage

```
apple_push your_config.yml
```

Sample configuration file:

```yml
---
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