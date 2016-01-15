![](https://dl.dropboxusercontent.com/s/aur3e9a0digi2md/2016-01-15%20at%201.25%20PM.png)

### turd

Turd is a little wrapper around typhoeus which is a wrapper around curb which is a wrapper around libcurl which is a wrapper around tcp which is a wrapper around electrons and shit. You can use turd to test http requests and responses. We use it at GitHub to validate responses from various services and alert us if they do not conform to the expected responses. http integration tests if you will. It can be also used for basic telnet-like plain text request validations. Lastly, it also produces some basic diagnostic data like various timings from libcurl.

It is called "turd" because my cat pooped on the floor while I was writing it.

#### Usage

Check out the examples directory for usage details. The basic idea is you define a request and response. turd performs the request and compares the actual response with the expected response. You can use any data that a typhoeus response object supplies to validate responses (header and body substrings, status codes, etc).

#### License

turd is open source software available under the MIT License
