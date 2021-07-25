---
layout: page
permalink: /projects/jwt/
title: JWT - JSON Web Token Decoder
desc: JWT is a macOS application to safely and securely decode JSON Web Tokens without sending any data to the Internet.
keywords: macOS, jwt, json, web, token, auth, authorization
image: https://enekoalonso.com/media/jwt/jwt-app.png
---

![JWT JSON Web Token decoder macOS application](/media/jwt/jwt-app.png)

**JWT** is a macOS application for securely decoding JSON Web Tokens without sending any information to the
Internet.


## Installation

[JWT JSON Web Token Decoder](https://apps.apple.com/us/app/jwt-json-web-token-decoder/id1578129230) is
available in the macOS App Store.

[![Download JWT JSON Web Token Decoder App](/media/Download_on_the_App_Store.svg)](https://apps.apple.com/us/app/jwt-json-web-token-decoder/id1578129230)


## Features

- 🤝 Safely decode JSON Web Tokens
- 📄 Extract header and payload information
- 🖱 Easily copy data with one-click


## Changelog

### Version 1.0 (July 24, 2021)
- Initial release


## Privacy

This application does not have any capabilities to send or receive network data. There are no analytics, no
tracking, and no other means of communication. It is designed to be safe, keeping tokens local to your
computer.

![macOS entitlements & capabilities](/media/jwt/app-capabilities.png)


## About JSON Web Tokens

### Structure

#### Header
Identifies which algorithm is used to generate the signature HS256 indicates that this token is
signed using HMAC-SHA256.

Typical cryptographic algorithms used are HMAC with SHA-256 (HS256) and RSA signature with
SHA-256 (RS256). JWA (JSON Web Algorithms) RFC 7518 introduces many more for both authentication
and encryption.

#### Payload
Contains a set of claims. The JWT specification defines seven Registered Claim Names which are the
standard fields commonly included in tokens. Custom claims are usually also included, depending on the
purpose of the token.

This example has the standard Issued At Time claim (iat) and a custom claim (loggedInAs).

#### Signature
Securely validates the token. The signature is calculated by encoding the header and payload using
Base64url Encoding RFC 4648 and concatenating the two together with a period separator. That string is
then run through the cryptographic algorithm specified in the header, in this case HMAC-SHA256. The
Base64url Encoding is similar to base64, but uses different non-alphanumeric characters and omits padding.

### Example JWT Token

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dnZWRJbkFzIjoiYWRtaW4iLCJpYXQiOjE0MjI3Nzk2Mzh9.gzSraSYS8EXBxLN_oWnFSRgCzcmJmMjLiuyu5CSpyHI
```

![Sample Token Decoded](/media/jwt/sample-token.png)

## Contact

For any feedback or concerns, please reach out to [@eneko](https://twitter.com/eneko) on Twitter.
